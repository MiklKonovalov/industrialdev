//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Misha on 16.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit
import iOSIntPackage

// -Создаём таймер
let timer = Timer(timeInterval: 1, repeats: true) { _ in
    print("Some work")
}


// ***RUNLOOP + ТАЙМЕР***
//Таймер - гибкий инструмент для выполнения отложенных задач единожды или периодически
//Создаём свой собственный поток Thread
class ExampleThread: Thread {
    override func main() {
        // -у текущего ранлупа в данном потке мы добавляем таймер, в режиме common (этот режим позволяет делать что-то в главном потоке)
        RunLoop.current.add(timer, forMode: .common)
        // -запукаем ранлуп
        RunLoop.current.run()
    }
}

// -Пример Run-loop
class Some: NSObject {
    func generateNumber() {
        print("Current thread: \(Thread.current)")
        // -вызываем метод, который передаст работу в новый поток и эту работу мы укажем через имя функции
        Thread.detachNewThreadSelector(#selector(generate), toTarget: self, with: nil)
    }
    
    @objc private func generate() {
        print("Current thread: \(Thread.current)")
        // -этот код будет выполняться в отдельном потоке
        let result = Int.random(in: 1...10000)
        // -вызываем метод из Objective-C, который позволяет вызвать метод на любом потоке
        self.performSelector(onMainThread: #selector(printResult(number:)),
                             with: NSNumber(value: result), // - передаём наш результат
                             waitUntilDone: true) // - true - будет ждать пока метод выполнится на главном потоке
        
        }
    
    @objc private func printResult(number: NSNumber) {
        print("Current thread: \(Thread.current)")
        // -передаём выполнение result на главный поток, что бы распечатать/показать на экране (все манипуляции с интерфейсом, который мы видим на экране должны происходить в главном потоке)
        print("Result: \(number)")
    }
}


// ***СОЗДАЁМ ПОТОК МЕТОДОМ THREAD***
//class MyThread: Thread {
//
//    override func main() {
//        var count: Int = 0
//        for _ in 0...20 {
//            count += 1
//        }
//        print("Current thread: \(Thread.current)")
//        print("count: \(count)")
//    }
//
//}

//ImageLibrarySubscriber - это Паблишер
class PhotosViewController: UIViewController, ImageLibrarySubscriber {
    //Создаём домен ошибок
    
    let thread = ExampleThread()
    
    // -создаём объект и у объекта вызываем метод
    let some = Some()
    
    var newArrayForImage: [UIImage] = []
    
    //Data source для массива изображений
    var receivedImages: [UIImage] = []
    
    func receive(images: [UIImage]) {
        //Записываем картинки в новый датасорс
        for images in newArrayForImage {
            receivedImages.append(images)
        }
        self.collectionView.reloadData()
        print(type(of: self), #function)
    }
    
    //ImagePublisherFacade содержит методы добавления, удаления наблюдателя и вызов нотификации
    var imagePublisherFacade: ImagePublisherFacade? = .init()
    
    var imageProcessor: ImageProcessor? = .init()
    
    var labelString: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        title = "Photos Gallery"
        navigationController?.title = labelString
        
    }
    
    //MARK: setup collection
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotoCollectionViewCell.self)) //1. Зарегистрировали ячейку
        collectionView.dataSource = self //dataSurce даёт инфо по количеству ячеек и секций
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionsConstraints()
        
        thread.start()
        
        some.generateNumber()
        
        receivedImages.append(UIImage(named: "1") ?? UIImage())
        
        newArrayForImage.append(UIImage(named: "cosmos") ?? UIImage())

        //подписываем класс PhotosViewController на изменения
        imagePublisherFacade?.subscribe(self)
        
        imagePublisherFacade?.addImagesWithTimer(time: 1, repeat: 10, userImages: RugbyFlow.rugbySections.imageArrayOfRugbyPhotos as? [UIImage])

// *СПОСОБ 1*
        //Для выполнения загрузки данных, что может занять значительное время и заблокировать Main queue, мы АСИНХРОННО переключаем выполнение этого ресурса-емкого задания на глобальную параллельную очередь с качеством обслуживания qos, равным .utility
       
        //Очередь, которая будет работать в фоне
        let queue = DispatchQueue.global(qos: .utility)

        // DispatchQueue.main - это очередь с самым высоким приоритетом. Добавляем в очердь queue ещё одну задачу
        queue.async {
            DispatchQueue.main.async {
                self.imageProcessor?.processImagesOnThread(
                    sourceImages: self.receivedImages,
                    filter: .fade,
                    qos: .background) {_ in
                }
                print("Show one")
            }
            print("Show two")
        }

// *СПОСОБ 2*
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.imageProcessor?.processImagesOnThread(
//                    sourceImages: self.receivedImages,
//                    filter: .fade,
//                    qos: .background) {_ in
//                }
//        }
 
// *СПОСОБ 3*
//        let serialQueue = DispatchQueue(label: "new")
//        let currentQueue = DispatchQueue(label: "array", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
//
//        currentQueue.async {
//            self.imageProcessor?.processImagesOnThread(
//                sourceImages: self.receivedImages,
//                filter: .fade,
//                qos: .background) {_ in
//            }
//
//        }

}
    
    //MARK: setup collection's constraint
    private func setupCollectionsConstraints() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            ]

        NSLayoutConstraint.activate(constraints)

        }

}

//MARK: DataSource

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        receivedImages.count
    }

    //создаём ячейку, которая будет отображать данные
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as! PhotoCollectionViewCell
        
        let rugbyFlow = RugbyFlow.rugbySections.imageArrayOfRugbyPhotos[indexPath.item]
        
        cell.photos = rugbyFlow
        
       return cell
    }
}

//MARK: Delegate

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 32) / 3
        return CGSize(width: width, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

}
