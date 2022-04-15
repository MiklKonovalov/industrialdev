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

//ImageLibrarySubscriber - это Паблишер
class PhotosViewController: UIViewController, ImageLibrarySubscriber {
    
    var newArrayForImage: [UIImage] = []
    
    //Data source для массива изображений
    var receivedImages: [UIImage] = []
    
    func receive(images: [UIImage]) {
        //Записываем картинки в новый датасорс
        for images in newArrayForImage {
            receivedImages.append(images)
        }
        self.collectionView.reloadData()
    }
    
    //ImagePublisherFacade содержит методы добавления, удаления наблюдателя и вызов нотификации
    var imagePublisherFacade: ImagePublisherFacade? = .init()
    
    var imageProcessor: ImageProcessor? = .init()
    
    var labelString: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.title = labelString
        
    }
    
    //MARK: setup collection
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotoCollectionViewCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionsConstraints()
        
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
