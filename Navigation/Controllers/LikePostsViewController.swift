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
        
        /*let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        
        do {
            try context.save()
        }
        catch {
            
        }*/
        
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
    
    /*func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableview.beginUpdates()
            postArray.remove(at: indexPath.row)
            tableview.deleteRows(at: [indexPath], with: .fade)
            
            tableview.endUpdates()
        }
    }*/
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //Delete
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            
            guard let post = self.postArray[indexPath.row], self.postArray[indexPath.row] != nil else { return }
            self.context.delete(post)
            do {
                try self.context.save()
                self.postArray.remove(at: indexPath.row)
                self.tableview.deleteRows(at: [indexPath], with: .automatic)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            completionHandler(true)
        }
        
        //Swipe
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
        
    }

}
