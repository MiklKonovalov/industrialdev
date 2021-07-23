//
//  PhotoCollectionViewCell.swift
//  Navigation
//
//  Created by Misha on 15.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage
//тут работаем с ячейкой, делаем вёрстку
class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    var photos: UIImage? {
        didSet {
            rugbyImage.image = photos
        }
    }
    
    var rugbyImage: UIImageView = {
        let rugbyImage = UIImageView()
        rugbyImage.contentMode = .scaleAspectFill
        rugbyImage.clipsToBounds = true
        rugbyImage.translatesAutoresizingMaskIntoConstraints = false
        return rugbyImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        contentView.addSubview(rugbyImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension PhotoCollectionViewCell {
    func setupViews() {
    contentView.addSubview(rugbyImage)
        
    let constraints = [
        rugbyImage.topAnchor.constraint(equalTo: contentView.topAnchor),
        rugbyImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        rugbyImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        rugbyImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        
    ]
    
    NSLayoutConstraint.activate(constraints)
        
    }
}
