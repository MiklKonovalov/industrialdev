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
    
    let persistanceManager = PersistanceManager.shared
    
    //Проверяем, есть ли у нас какие-либо данные в CoreData и отображаем их
    let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
    
    let cellId = "cellId"
    
    weak var coordinator: MainCoordinator?
    
    var postArray = [Post?]() {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Чтение данных проходит в основном потоке
            //Пробуем получить данные
            do {
                self.postArray = try self.persistanceManager.context.fetch(self.fetchRequest)
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(addFilter))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelFilter))
        
    }
    
    @objc func addFilter() {
        print("addFilter")
        
        let searchPostsViewController = SearchPostsViewController()
        searchPostsViewController.callback = { (value) in
            DispatchQueue.main.async {
                print(value)
                self.fetchAuthor(userName: value)
                self.tableview.reloadData()
            }
            print("CallBack")
        }
        present(searchPostsViewController, animated: true, completion: nil)
        
    }
    
    @objc func cancelFilter() {
        print("cancelFilter")
        
        let context = persistanceManager.persistentContainer.newBackgroundContext()
        //Запускаем потокобезопасную функцию, которая запустит код асинхронно
        context.perform {
            do {
                self.postArray = try self.persistanceManager.context.fetch(self.fetchRequest)
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        
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
    
    func fetchAuthor(userName: String) {
        
        let request = Post.fetchRequest() as NSFetchRequest<Post>
        let author = userName
        let predicate = NSPredicate(format: "%K = %@", #keyPath(Post.userName), author)
        request.predicate = predicate
        
        let context = persistanceManager.persistentContainer.newBackgroundContext()
        //Запускаем потокобезопасную функцию, которая запустит код в асинхронно
        context.perform {
            do {
                let result = try self.persistanceManager.context.fetch(request)
                self.postArray = result
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //Delete
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            
            guard let post = self.postArray[indexPath.row], self.postArray[indexPath.row] != nil else { return }
            
            let context = self.persistanceManager.persistentContainer.newBackgroundContext()
            context.automaticallyMergesChangesFromParent = true
            //Запускаем потокобезопасную функцию, которая запустит код асинхронно и дожидается результата перед тем, как отобразить в UI
            context.performAndWait {
                self.persistanceManager.context.delete(post)
                do {
                    try self.persistanceManager.context.save()
                    self.postArray.remove(at: indexPath.row)
                    self.tableview.deleteRows(at: [indexPath], with: .automatic)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            
            completionHandler(true)
        }
        
        //Swipe
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
        
    }
    
}
