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
    
//    func check(word: String) -> String {
//        if word == textField.text {
//            print("true")
//        } else {
//            print("false")
//        }
//        return word
//    }
    
    
    var onText: ((String) -> Void)?
    
    var model: ModelInput?
    
    init(model: ModelInput, onText: ((String) -> Void)?) {
        self.onText = onText
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let post: Post = Post(title: "Пост")
    
    @IBAction func mainButton(_ sender: UIButton) {
        guard let text = mainTextField.text, text.count > 0 else { return }
        
        let model = CheckModel()
        
        model.check(word: text) { isRight in
            label.textColor = isRight ? .green : .red
            label.text = isRight ? "Right!" : "Wrong!"
        }
        
        UIView.animate(withDuration: 0.3) {
            self.label.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.3) {
                self.label.alpha = 0
            }
        }
    }
    
    @IBOutlet weak var mainTextField: UITextField!
    
    
    @IBOutlet weak var label: UILabel!
    //не понял это замыкание
    private lazy var textField: TextInput = {
        let textField = TextInput(onText: {
            [weak self] text in
            self?.textField.text = text
            self?.textField.backgroundColor = .orange
            self?.textField.tintColor = .red
        })
        return textField
    }()
    
    private lazy var textField2: UITextField = {
//        let tf = UITextField()
//        let textField = TextInput(onText: {
//            [weak self] text in
//            self?.textField2.text = text
//            self?.textField2.backgroundColor = .orange
//            self?.textField2.tintColor = .red
//        })
        return UITextField(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(textField)
        self.view.addSubview(button)
        //self.view.addSubview(textField2)
        label.alpha = 0
        
        let constraints = [
            
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 60),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            //textField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: 0.1),
            textField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: 1),
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            
//            textField2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
//            textField2.leadingAnchor.constraint(equalTo: button.leadingAnchor),
//            textField2.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            
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

