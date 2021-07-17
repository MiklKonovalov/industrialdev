//
//  LogInViewController.swift
//  Navigation
//
//  Created by Misha on 06.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

//Протокол делегирования проверки логинаи пароля. Он имеет несколько параметров, данных для передачи обратно вызвавшему контроллеру. В данном случае я передаю обратно контроллеру логин и пароль.
protocol LogInViewControllerDelegate: AnyObject {
    //1.1 В методе делегата передаём экземпляр делегирующего объекта, чтобы вернуть результат работы
    func checkValue(login: String, password: String) -> User?

}

//Фабрика п1: Создайте protocol LoginFactory с 1 методом без параметров, который возвращает LoginInspector.

//Комментарий: Объявляем интерфейс, который будет играть роль «абстрактной фабрики»:
protocol LoginFactory {
    //Создаём фабричный метод (Фабричный метод - это метод, который что-то возвращает), который возвращает LoginInspector. Мы знаем, что фабрика должна проверять логин и пароль, по-этому, когда мы пишем общий интерфейс для фабрики, мы возвращаем LjginInspector. Интерфейс абстрактной фабрики содержит один метода: для проверки логина и пароля. Метод возвращает экземпляр общего базового класса? Таким образом, ограничивается область распространения знаний о конкретных типах пределами той области, в которой это действительно необходимо.
    func checkLoginByFactory() -> LoginInspetor
}

// Слой Presentation: M-V-C (V + C)

class LogInViewController: UIViewController {
    
    //1.2 Объявляем делегата для использования. В контроллере мы создаем instance протокола и называем его делегат
    weak var delegate: LogInViewControllerDelegate?
    
    //В контроллере у нас есть зависимость от фабрики. Она жёсткая, так как мы внедряем её через инициализатор
    private var factory: LoginInspetor?
    
    //MARK: Create subviews
    let substrate: UIView = {
        let substrate = UIView()
        substrate.layer.borderColor = UIColor.lightGray.cgColor
        substrate.layer.borderWidth = 0.5
        substrate.layer.cornerRadius = 10
        substrate.layer.backgroundColor = UIColor.systemGray6.cgColor
        substrate.translatesAutoresizingMaskIntoConstraints = false
        return substrate
    }()
    
    let spaceForEmailView: UIView = {
        let spaceView = UIView()
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        return spaceView
    }()
    
    let spaceForPasswordView: UIView = {
        let spaceView = UIView()
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        return spaceView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let myView: UIView = {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    private var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = #imageLiteral(resourceName: "logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    private var userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.layer.borderColor = UIColor.white.cgColor
        userNameTextField.layer.cornerRadius = 10
        userNameTextField.layer.backgroundColor = UIColor.systemGray6.cgColor
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "Email or phone"
        userNameTextField.leftViewMode = .always
        return userNameTextField
    }()
    
    private var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.backgroundColor = UIColor.systemGray6.cgColor
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.leftViewMode = .always
        return passwordTextField
    }()
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton(title: "Login", titleColor: .gray ) {
            self.logInButtonPressed()
        }
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var separator: UIView = {
        let separator = UIView()
        separator.layer.backgroundColor = UIColor.lightGray.cgColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    private var model: ModelInput
    
    init(model: ModelInput) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func logInButtonPressed() {
        
        guard let userName = userNameTextField.text, let  passValue = passwordTextField.text else { return }
    #if DEBUG
        let userService = TestUserService()
    #else
        let userService = CurrentUserService()
    #endif
        var profileViewController = ProfileViewController(userService: userService, userName: userName) {
            didSet {
                //1.4. Метод делегата проверяет значения, введенные в 2 UITextField контроллера
                delegate?.checkValue(login: userName , password: passValue)
            }
        }
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    // MARK: Keyboard notifications
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard Actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    //MARK: Add subviews
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(myView)
        
        userNameTextField.leftView = spaceForEmailView
        passwordTextField.leftView = spaceForPasswordView
        
        myView.addSubview(substrate)
        myView.addSubview(spaceForPasswordView)
        myView.addSubview(spaceForEmailView)
        myView.addSubview(logoImageView)
        myView.addSubview(userNameTextField)
        myView.addSubview(passwordTextField)
        myView.addSubview(separator)
        myView.addSubview(logInButton)
        
        passwordTextField.isSecureTextEntry = true
        
    //MARK: Create constraints
       
        let constraints = [
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            myView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            myView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            myView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            myView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            myView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            substrate.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 15),
            substrate.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -15),
            substrate.topAnchor.constraint(equalTo: userNameTextField.topAnchor, constant: -1),
            substrate.heightAnchor.constraint(equalToConstant: 100.0),
            substrate.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 1),
            
            spaceForEmailView.topAnchor.constraint(equalTo: userNameTextField.topAnchor),
            spaceForEmailView.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor),
            spaceForEmailView.widthAnchor.constraint(equalToConstant: 10.0),
            spaceForEmailView.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            
            spaceForPasswordView.topAnchor.constraint(equalTo: passwordTextField.topAnchor),
            spaceForPasswordView.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor),
            spaceForPasswordView.widthAnchor.constraint(equalToConstant: 10.0),
            spaceForPasswordView.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: myView.topAnchor, constant: 120),
            //logInButton.heightAnchor.constraint(equalToConstant: 100.0),
            logoImageView.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100.0),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            userNameTextField.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            userNameTextField.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50.0),
            userNameTextField.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 173),
            
            passwordTextField.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: -4),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
            
            separator.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
            separator.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 0),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            
            logInButton.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logInButton.bottomAnchor.constraint(equalTo: myView.bottomAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50.0)
            
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
}

//4. Создаем произвольный класс/структуру LoginInspector (или придумайте свое название), который подписывается на протокол LoginViewControllerDelegate, реализуем в нем протокольный метод.
//5. LoginInspector проверяет точность введенного пароля с помощью синглтона Checker.
class LoginInspetor: LogInViewControllerDelegate {
    func checkValue(login: String, password: String) -> User? {
        
        Checker.shared.checkLoginAndPassword(param: login, param: password)
        
            if login == "1" && password == "2" {
                return Checker.shared.user
            }
            return Checker.shared.user
    }
    
}

//Фабрика п2: Вынесите генерацию LoginInspector из SceneDelegate (или AppDelegate) в фабрику: создайте объект MyLoginFactory (название на ваше усмотрение), подпишите на протокол.

//Комментарий: Тут мы реализуем логику фабрики:
struct MyLoginFactory: LoginFactory {
    
    func checkLoginByFactory() -> LoginInspetor {
        print("check login")
        return LoginInspetor()
    }
}

//Фабрика п4: Внедрите зависимость контроллера от LoginInspector, создав инспектора с помощью фабричного метода.

//Комментарий: Логика в dataSource контроллера. У нас есть задача показать юзера, которую мы выполняем.
//extension LogInViewController {
//
//    func dataSourceFunction() -> User {
//        let inspector = factory?.checkLoginByFactory()
//        let user = inspector?.checkValue(login: "1", password: "2")
//        return user!
//    }
//
//}
