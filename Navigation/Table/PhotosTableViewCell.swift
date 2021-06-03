//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Misha on 14.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
//тут создаём colletionView
final class PhotosTableViewCell: UITableViewCell {
    
    var images: Images? {
        didSet {
            firstImageView.image = images?.image
            secondImageView.image = images?.secondImage
            thirdImageView.image = images?.thirdImage
            fourthImageView.image = images?.fourthImage
            photoLableView.text = images?.title
            arrowLableView.text = images?.arrow
        }
    }
    
    var photoLableView: UILabel = {
        let photoLableView = UILabel()
        photoLableView.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        photoLableView.textColor = .black
        photoLableView.translatesAutoresizingMaskIntoConstraints = false
        return photoLableView
    }()
    
    var arrowLableView: UILabel = {
        let arrowLableView = UILabel()
        arrowLableView.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        arrowLableView.textColor = .black
        arrowLableView.translatesAutoresizingMaskIntoConstraints = false
        return arrowLableView
    }()
    
    var firstImageView: UIImageView = {
        let firstImageView = UIImageView()
        firstImageView.contentMode = .scaleAspectFill
        firstImageView.clipsToBounds = true
        firstImageView.layer.cornerRadius = 6
        firstImageView.translatesAutoresizingMaskIntoConstraints = false
        return firstImageView
    }()
    
    var secondImageView: UIImageView = {
        let secondImageView = UIImageView()
        secondImageView.contentMode = .scaleAspectFill
        secondImageView.clipsToBounds = true
        secondImageView.layer.cornerRadius = 6
        secondImageView.translatesAutoresizingMaskIntoConstraints = false
        return secondImageView
    }()
    
    var thirdImageView: UIImageView = {
        let thirdImageView = UIImageView()
        thirdImageView.contentMode = .scaleAspectFill
        thirdImageView.clipsToBounds = true
        thirdImageView.layer.cornerRadius = 6
        thirdImageView.translatesAutoresizingMaskIntoConstraints = false
        return thirdImageView
    }()
    
    var fourthImageView: UIImageView = {
        let fourthImageView = UIImageView()
        fourthImageView.contentMode = .scaleAspectFill
        fourthImageView.clipsToBounds = true
        fourthImageView.layer.cornerRadius = 6
        fourthImageView.translatesAutoresizingMaskIntoConstraints = false
        return fourthImageView
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }
    
}
    
private extension PhotosTableViewCell {
    func setupViews() {
    contentView.addSubview(firstImageView)
    contentView.addSubview(secondImageView)
    contentView.addSubview(thirdImageView)
    contentView.addSubview(fourthImageView)
    contentView.addSubview(photoLableView)
    contentView.addSubview(arrowLableView)
        
    let constraints = [
        firstImageView.topAnchor.constraint(equalTo: photoLableView.bottomAnchor, constant: 12),
        firstImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
        firstImageView.heightAnchor.constraint(equalToConstant: 70),
        firstImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        firstImageView.widthAnchor.constraint(equalToConstant: 100),

        secondImageView.topAnchor.constraint(equalTo: firstImageView.topAnchor),
        secondImageView.leadingAnchor.constraint(equalTo: firstImageView.trailingAnchor, constant: 8),
        secondImageView.bottomAnchor.constraint(equalTo: firstImageView.bottomAnchor),
        secondImageView.widthAnchor.constraint(equalToConstant: 100),

        thirdImageView.topAnchor.constraint(equalTo: firstImageView.topAnchor),
        thirdImageView.leadingAnchor.constraint(equalTo: secondImageView.trailingAnchor, constant: 8),
        thirdImageView.bottomAnchor.constraint(equalTo: firstImageView.bottomAnchor),
        thirdImageView.widthAnchor.constraint(equalToConstant: 100),

        fourthImageView.topAnchor.constraint(equalTo: firstImageView.topAnchor),
        fourthImageView.leadingAnchor.constraint(equalTo: thirdImageView.trailingAnchor, constant: 8),
        fourthImageView.bottomAnchor.constraint(equalTo: firstImageView.bottomAnchor),
        fourthImageView.widthAnchor.constraint(equalToConstant: 100),
        
        photoLableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
        photoLableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
        //photoLableView.heightAnchor.constraint(equalToConstant: 70),
        photoLableView.bottomAnchor.constraint(equalTo: firstImageView.topAnchor, constant: -12),

        arrowLableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
        arrowLableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        //photoLableView.heightAnchor.constraint(equalToConstant: 70),
        arrowLableView.bottomAnchor.constraint(equalTo: fourthImageView.topAnchor, constant: -12),
        
    ]
    
    NSLayoutConstraint.activate(constraints)
        
    }
}


