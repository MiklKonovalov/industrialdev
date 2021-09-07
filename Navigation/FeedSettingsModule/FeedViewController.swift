//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

//Контроллер отвечает за то, как будут отображаться данные из модели.
//Контроллер не зависит от модели (не обращается к ней)
final class FeedViewController: UIViewController {
    
    var appConfiguration: AppConfiguration?
    
    //так как у нас есть паттерн Фабрика, то мы прописываем зависимость от неё
    public var factory: ControllerFactory?
    
    var onText: ((String) -> Void)?
    
    var viewModel: SettingsViewOutput
    
    // Контроллер через инициализатор принимает ViewModel как зависимость
    init(viewModel: SettingsViewOutput, factory: ControllerFactory, onText: ((String) -> Void)?) {
        self.onText = onText
        self.viewModel = viewModel
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.backgroundColor = UIColor.systemGray6.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var showModuleButton: CustomButton = {
        let button = CustomButton(title: "ShowModule", titleColor: .green, onTap: {
            self.showNextModule()
        })
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonPressed), for: .editingChanged)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textColor = .yellow
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Check the password!"
        return label
    }()
    
    @objc private func buttonPressed() {
        guard let text = textField.text, text.count > 0 else { return }
        
        // Контроллер обрабатывает нажатие через вью модель
        let viewModel = CheckModel()
        
        // Отправляет запросы к ViewModel
        //-Получает подготовленные для отображения данные
        //-Отправляет события, возможно с параметрами
        viewModel.check(word: text) { isRight in
            label.textColor = isRight ? .green : .red
            label.text = isRight ? "Ok" : "No"
        }
        //Устанавливаем анимацию длительность 0,3 сек на появление alpha
        UIView.animate(withDuration: 0.3) {
            self.label.alpha = 1
        }
        //Устанавливаем асинхронную анимацию через 1 секунду длительностью 0.3 сек для прозрачности лейбла в 100%
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        UIView.animate(withDuration: 0.3) {
            self.label.alpha = 0
            }
        }
        
    }
    
    private func showNextModule() {
        //Мы попросим viewModel передать touch event о том, что нужно показать другой модуль
        print("Должен показаться другой вью контроллер")
        viewModel.onTapShowNextModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(textField)
        self.view.addSubview(button)
        self.view.addSubview(label)
        self.view.addSubview(showModuleButton)
        //устанавливаем непрозрачность для label 100%
        label.alpha = 0
        
        let constraints = [
            
            textField.topAnchor.constraint(equalTo: button.topAnchor,constant: 50),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 50),
            
            showModuleButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            showModuleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            showModuleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            showModuleButton.heightAnchor.constraint(equalToConstant: 50),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
}

