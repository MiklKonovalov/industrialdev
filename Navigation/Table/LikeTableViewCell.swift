//
//  LikeTableViewCell.swift
//  Navigation
//
//  Created by Misha on 25.09.2021.
//

import Foundation
import UIKit
import CoreData

class LikeTableViewCell: UITableViewCell {
    
    let coreDataStack = CoreDataStack.shared
    
    var posts: LikePost? {
        didSet {
            userNameLable.text = posts?.autor
            descriptionLable.text = posts?.description
            likesLable.text = String(posts!.numberOfLikes)
            viewsLable.text = String(posts!.numberOfviews)
            flowImageView.image = posts?.image
            
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
        
        /*let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Manager> = Manager.fetchRequest()
        
        do {
            userName = try context.fetch(fetchRequest)
            print(userName)
        } catch let error as NSError {
            print(error.localizedDescription)
        }*/
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension LikeTableViewCell {
    func setupViews() {
        contentView.addSubview(userNameLable)
        contentView.addSubview(descriptionLable)
        contentView.addSubview(likesLable)
        contentView.addSubview(viewsLable)
        contentView.addSubview(flowImageView)
        
        selectionStyle = .none
        
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
