//
//  LikePostsViewController.swift
//  Navigation
//
//  Created by Misha on 25.09.2021.
//

import Foundation
import UIKit
import CoreData

class LikePostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableview: UITableView = {
            let tableview = UITableView()
            tableview.backgroundColor = UIColor.white
            tableview.translatesAutoresizingMaskIntoConstraints = false
            return tableview
        }()
    
    let cellId = "cellId"
    
    var posts: [LikePost] = [LikePost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createPostsArray()
        setupTableView()
        
    }
    
    func setupTableView() {
        tableview.register(LikeTableViewCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(tableview)
        let constraints = [
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LikeTableViewCell
        cell.backgroundColor = UIColor.white
        
        let currentLastItem = posts[indexPath.row]
        cell.posts = currentLastItem
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func createPostsArray() {
        posts.append(LikePost(autor: "1", description: "1", image: UIImage(named: "регби")!, numberOfLikes: 1, numberOfviews: 1))
        posts.append(LikePost(autor: "2", description: "2", image: UIImage(named: "регби")!, numberOfLikes: 2, numberOfviews: 2))
        posts.append(LikePost(autor: "3", description: "3", image: UIImage(named: "регби")!, numberOfLikes: 3, numberOfviews: 3))
    }
    
}
