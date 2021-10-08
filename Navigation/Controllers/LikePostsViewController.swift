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
    
    //Проверяем, есть ли у нас какие-либо данные в CoreData и отображаем их
    let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
    
    let cellId = "cellId"
    
    weak var coordinator: MainCoordinator?
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var postArray = [Post?]() {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Пробуем получить данные
        do {
            self.postArray = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
 
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
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LikeTableViewCell
        cell.backgroundColor = UIColor.white
        
        let post = self.postArray[indexPath.row]
        
        cell.post = post
        
        return cell
    }
    
}

