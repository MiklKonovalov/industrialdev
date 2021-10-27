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
    
    let cellId = "cellId"
    
    weak var coordinator: MainCoordinator?
    
    var postArray = [Post?]() {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    lazy var fetchResultController: NSFetchedResultsController<Post> = {
        //Делаем запрос на получение данных
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        request.resultType = .managedObjectResultType
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Post.userName), ascending: true)]
        
        let controller = NSFetchedResultsController(
                fetchRequest: request,
            managedObjectContext: PersistanceManager.shared.persistentContainer.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
        )
        
        controller.delegate = self
        return controller
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do{
            try fetchResultController.performFetch()
            tableview.reloadData()
        }
        catch let error {
            print(error)
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
        
        fetchResultController.fetchRequest.predicate = nil
       
        do{
            try fetchResultController.performFetch()
            tableview.reloadData()
        }
        catch let error {
            print(error)
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
 
        self.fetchResultController.fetchRequest.predicate = predicate
        try? self.fetchResultController.performFetch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sectionInfo = fetchResultController.sections?[section] else { return 0 }
        
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LikeTableViewCell
        cell.backgroundColor = UIColor.white
        
        let post = fetchResultController.object(at: indexPath)
        
        cell.post = post
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //Delete
        let deleteRow = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            
            let context = self.persistanceManager.persistentContainer.newBackgroundContext()
            context.automaticallyMergesChangesFromParent = true
            
            context.performAndWait {
                let post = self.fetchResultController.object(at: indexPath)
                self.fetchResultController.managedObjectContext.delete(post)
            }
        }
        
        //Swipe
        let swipe = UISwipeActionsConfiguration(actions: [deleteRow])
        return swipe
    }
}

extension LikePostsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableview.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableview.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            let cell = tableview.cellForRow(at: indexPath!) as! LikeTableViewCell
            let post = fetchResultController.object(at: indexPath!)
            cell.post = post
        case .move:
            tableview.deleteRows(at: [indexPath!], with: .automatic)
            tableview.insertRows(at: [newIndexPath!], with: .automatic)
        default:
            print("Unexpected NSFetchedResultsCgangeType")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.endUpdates()
    }
}
