//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

//Контроллер отвечает за то, как будут отображаться данные из модели.

//Контроллер должен быть подписан на изменения модели. Через Notifications?

final class FeedViewController: UIViewController {
    
    var onText: ((String) -> Void)?
    
    var model: ModelInput
    
    init(onText: ((String) -> Void)?, model: ModelInput) {
        self.onText = onText
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let post: Post = Post(title: "Пост")
    
    private lazy var textField: TextInput = {
        let textField = TextInput(onText: {
            [weak self] text in
            self?.textField.text = text
        })
        return textField
    }()
    
    private lazy var button: CustomButton = {
        let button = CustomButton(title: "Button", titleColor: .yellow, onTap: {
            self.buttonPressed()
        })
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonPressed), for: .editingChanged)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func buttonPressed() {
        model.check(word: textField.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(textField)
        self.view.addSubview(button)
        
        let constraints = [
            
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        print(type(of: self), #function)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "post" else {
            return
        }
        guard let postViewController = segue.destination as? PostViewController else {
            return
        }
        postViewController.post = post
    }
}

