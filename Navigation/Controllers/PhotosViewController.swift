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
    
    var receivedImages: [UIImage] = []
    
    func receive(images: [UIImage]) {
    
        for images in newArrayForImage {
            receivedImages.append(images)
        }
        
        self.collectionView.reloadData()
        print(type(of: self), #function)
    }
    
    //ImagePublisherFacade содержит методы добавления, удаления наблюдателя и вызов нотификации
    var imagePublisherFacade: ImagePublisherFacade? = .init()
    
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
        
        receivedImages.append(UIImage(named: "1") ?? UIImage())
        //receivedImages.append(UIImage(named: "2") ?? UIImage())
        //receivedImages.append(UIImage(named: "3") ?? UIImage())
        //receivedImages.append(UIImage(named: "4") ?? UIImage())
        //receivedImages.append(UIImage(named: "5") ?? UIImage())
        //receivedImages.append(UIImage(named: "6") ?? UIImage())
        //receivedImages.append(UIImage(named: "7") ?? UIImage())
        //receivedImages.append(UIImage(named: "8") ?? UIImage())
        //receivedImages.append(UIImage(named: "9") ?? UIImage())
        //receivedImages.append(UIImage(named: "10") ?? UIImage())
        
        newArrayForImage.append(UIImage(named: "cosmos") ?? UIImage())
        
        //подписываем класс PhotosViewController на изменения
        imagePublisherFacade?.subscribe(self)
        
        //Запускаем сценарий выполнения публикации
        imagePublisherFacade?.addImagesWithTimer(time: 1, repeat: 12, userImages: RugbyFlow.rugbySections.imageArrayOfRugbyPhotos as? [UIImage])
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
        
        //let rugbyFlow = receivedImages[indexPath.item]
        
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
