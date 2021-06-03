//
//  FlowTableViewCell.swift
//  Navigation
//
//  Created by Misha on 11.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class FlowTableViewCell: UITableViewCell {
    
    var fasting: Fasting? {
        didSet {
            userNameLable.text = fasting?.autor
            descriptionLable.text = fasting?.description
            likesLable.text = "Likes:" + String(fasting!.numberOfLikes)
            viewsLable.text = "Views:" + String(fasting!.numberOfviews)
            flowImageView.image = fasting?.image
        }
    }
    
    private let userNameLable: UILabel = {
        let userNameLable = UILabel()
        userNameLable.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        userNameLable.textColor = .black
        userNameLable.translatesAutoresizingMaskIntoConstraints = false
        return userNameLable
    }()
    
    private let descriptionLable: UILabel = {
        let descriptionLable = UILabel()
        descriptionLable.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        descriptionLable.textColor = .darkGray
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLable
    }()
    
    private let likesLable: UILabel = {
        let likesLable = UILabel()
        likesLable.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        likesLable.textColor = .black
        likesLable.translatesAutoresizingMaskIntoConstraints = false
        return likesLable
    }()
    
    private let viewsLable: UILabel = {
        let viewsLable = UILabel()
        viewsLable.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        viewsLable.textColor = .black
        viewsLable.translatesAutoresizingMaskIntoConstraints = false
        return viewsLable
    }()
    
    private let flowImageView: UIImageView = {
        let flowImageView = UIImageView()
        flowImageView.contentMode = .scaleAspectFit
        flowImageView.translatesAutoresizingMaskIntoConstraints = false
        return flowImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        setupViews()
    }
    
}

private extension FlowTableViewCell {
    func setupViews() {
        contentView.addSubview(userNameLable)
        contentView.addSubview(descriptionLable)
        contentView.addSubview(likesLable)
        contentView.addSubview(viewsLable)
        contentView.addSubview(flowImageView)
        
        let constraints = [
            userNameLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userNameLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            userNameLable.heightAnchor.constraint(equalToConstant: 30),

            
            flowImageView.topAnchor.constraint(equalTo: userNameLable.bottomAnchor, constant: 10),
            flowImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            flowImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flowImageView.heightAnchor.constraint(equalToConstant: 350),
            
            descriptionLable.topAnchor.constraint(equalTo: flowImageView.bottomAnchor, constant: 10),
            descriptionLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLable.heightAnchor.constraint(equalToConstant: 30),

            likesLable.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 10),
            likesLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            likesLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            viewsLable.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 10),
            viewsLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            viewsLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
