//
//  SearchPostsViewController.swift
//  NavigationNew
//
//  Created by Misha on 14.10.2021.
//

import Foundation
import UIKit
import CoreData

/*protocol SearchPostsViewControllerDelegate {
    func reloadDataForFetch()
}*/

class SearchPostsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let likePostsViewController = LikePostsViewController()
    
    //var delegate: SearchPostsViewControllerDelegate?
    
    var callback : ((String) -> Void)?
    
    var authorTextField: UITextField = {
        let authorTextField = UITextField()
        authorTextField.layer.borderColor = UIColor.white.cgColor
        authorTextField.layer.cornerRadius = 10
        authorTextField.layer.backgroundColor = UIColor.systemGray6.cgColor
        authorTextField.translatesAutoresizingMaskIntoConstraints = false
        authorTextField.placeholder = "Username"
        authorTextField.leftViewMode = .always
        return authorTextField
    }()
    
    lazy var searchButton: CustomButton = {
        let button = CustomButton(title: "Применить", titleColor: .white ) {
            self.searchButtonPressed()
        }
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        view.addSubview(authorTextField)
        view.addSubview(searchButton)
        
        setConstraints()
        
    }
    
    @objc func searchButtonPressed() {
        print("Search Button is tapped")
        
        //fetchAuthor()
        callback?(authorTextField.text ?? "")
        dismiss(animated: true, completion: nil)
        
    }
    
    func setConstraints() {
        
        let constraints = [
        
            authorTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            authorTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            authorTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            authorTextField.heightAnchor.constraint(equalToConstant: 50),
            
            searchButton.topAnchor.constraint(equalTo: authorTextField.bottomAnchor, constant: 20),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
        
//Окончание класса
}
