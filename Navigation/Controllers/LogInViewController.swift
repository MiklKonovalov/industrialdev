//
//  LogInViewController.swift
//  Navigation
//
//  Created by Misha on 06.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol LogInViewControllerDelegate: AnyObject {
    func checkValue(login: String, password: String) -> User?
}

//Фабрика 1: Создайте protocol LoginFactory с 1 методом без параметров, который возвращает LoginInspector.
//Комментарий: Объявляем интерфейс, который будет играть роль «абстрактной фабрики»:
protocol LoginFactory {
    //Создаём фабричный метод (Фабричный метод - это метод, который что-то возвращает), который возвращает LoginInspector. Мы знаем, что фабрика должна проверять логин и пароль, по-этому, когда мы пишем общий интерфейс для фабрики, мы возвращаем LjginInspector. Интерфейс абстрактной фабрики содержит один метода: для проверки логина и пароля. Метод возвращает экземпляр общего базового класса? Таким образом, ограничивается область распространения знаний о конкретных типах пределами той области, в которой это действительно необходимо.
    //func checkLoginByFactory() -> LoginInspetor
}

// Слой Presentation: M-V-C (V + C)

class LogInViewController: UIViewController {
    
    let aColor = UIColor(named: "background")
    
    let brutForce = BrutForce()
    
    //var model: SettingsViewOutput
    
    weak var loginDelegate: LogInViewControllerDelegate?
    
    var loginCoordinator: LoginCoordinator
    
    //MARK: Create subviews
    let substrate: UIView = {
        let substrate = UIView()
        substrate.layer.borderColor = UIColor.systemGray2.cgColor
        substrate.layer.borderWidth = 0.5
        substrate.layer.cornerRadius = 10
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
        logoImageView.image = UIImage(named: "logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    var userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.layer.borderColor = UIColor.white.cgColor
        userNameTextField.layer.cornerRadius = 10
        userNameTextField.layer.backgroundColor = UIColor.systemGray6.cgColor
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "Email or phone"
        userNameTextField.leftViewMode = .always
        return userNameTextField
    }()
    
    var passwordTextField: UITextField = {
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
        let button = CustomButton(title: "Login", titleColor: .white ) {
            print("Custom Button Closure")
            self.logInButtonPressed()
        }
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.backgroundColor = UIColor.appColor(.buttoncolor)?.cgColor
        button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pickUpPass: CustomButton = {
        let button = CustomButton(title: "Pick up", titleColor: .white ) {
            //self.generatePassword(passwordLength: 10)
        }
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.backgroundColor = UIColor.appColor(.buttoncolor)?.cgColor
        button.addTarget(self, action: #selector(generatePassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var separator: UIView = {
        let separator = UIView()
        separator.layer.backgroundColor = UIColor.lightGray.cgColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    //MARK: -Inicialization
    init(loginCoordinator: LoginCoordinator) {
        self.loginCoordinator = loginCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//Используется, если есть storyboard
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    @objc private func logInButtonPressed() {
        //Тут должен логикой управлять координатор
        loginCoordinator.pressButtonAndCheck()
        
//        do {
//            let login = try loginHelper.validateUsername(userNameTextField.text)
//            let password = try loginHelper.validatePassword(passwordTextField.text)
//
//            let user = Checker.shared.user
//
//            _ = Checker.shared.checkLoginAndPassword(param: login , param: password)
//            if login == "1" && password == "2" {
//
//            let profileViewController = ProfileViewController(user: user)
//            self.navigationController?.pushViewController(profileViewController, animated: true)
//            } else {
//                throw ValidationError.invalidValue
//            }
//        }
//        catch {
//            print(error.localizedDescription)
//        }
        
//        if userNameTextField.text == "1" && passwordTextField.text == "2" {
//            let user = User(name: "Нет данных", avatar: UIImage(named: "gratis") ?? UIImage(), status: "Нет данных")
//            let profileViewController = ProfileViewController(user: user)
//            self.navigationController?.pushViewController(profileViewController, animated: true)
//        } else {
//            print("No user")
//        }
        
        //#if DEBUG
        //let user = loginDelegate?.checkValue(login: userNameTextField.text ?? "", password: passwordTextField.text ?? "") ?? User(name: "Нет данных", avatar: UIImage(named: "gratis") ?? UIImage(), status: "Нет данных")
        //#else
        //let userService = CurrentUserService()
        //#endif
        
    }
    
    @objc private func generatePassword(passwordLength: Int) -> String {
        
        //Создаём очередь на побочном потоке
        let queue = DispatchQueue(label: "my_queue",
                                  attributes: .concurrent)
        
        let taskGroup1 = DispatchGroup()
        let taskGroup2 = DispatchGroup()
        
        taskGroup1.enter()
        //First create an array with your password allowed characters
        let passwordCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        //then choose the password lenght
        let len = 10
        //define and empty string password
        var password = ""

        //create a loop to gennerate your random characters
        for _ in 0 ..< len {
            password.append(passwordCharacters.randomElement()!)
        }
        print("Генерация пароля завершена")
        taskGroup1.leave()
        
        taskGroup2.enter()
            queue.async {
                print("Начат подбор пароля")
                self.brutForce.bruteForce(passwordToUnlock: password)
            }
        taskGroup2.leave()
        
        taskGroup1.enter()
            self.createSpinnerView()
            print("работает activityIndicator")
        taskGroup1.leave()
        
        taskGroup2.wait()
        
        self.passwordTextField.text = password
        
        taskGroup1.notify(queue: DispatchQueue.main) {
            print("Подбор закончен")
        }
        
        return password
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        userNameTextField.layer.backgroundColor = UIColor.systemGray6.cgColor
        passwordTextField.layer.backgroundColor = UIColor.systemGray6.cgColor
        
        logInButton.layer.backgroundColor = UIColor.appColor(.buttoncolor)?.cgColor
        pickUpPass.layer.backgroundColor = UIColor.appColor(.buttoncolor)?.cgColor
        
    }
    
    //MARK: -Lifecucle
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: Keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = aColor
        
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
        myView.addSubview(pickUpPass)
        
        passwordTextField.isSecureTextEntry = false
        
        switch traitCollection.userInterfaceStyle {
        case .dark:
            break
        case .light:
            break
        default:
            print("test theme")
        }
        
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
            //logInButton.bottomAnchor.constraint(equalTo: myView.bottomAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50.0),
            
            pickUpPass.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            pickUpPass.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            pickUpPass.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
            pickUpPass.bottomAnchor.constraint(equalTo: myView.bottomAnchor),
            pickUpPass.heightAnchor.constraint(equalToConstant: 50.0)
            
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
}
    


//LoginInspector - это реализация делегата.
//4. Создаем произвольный класс/структуру LoginInspector (или придумайте свое название), который подписывается на протокол LoginViewControllerDelegate, реализуем в нем протокольный метод.
//5. LoginInspector проверяет точность введенного пароля с помощью синглтона Checker.
//class LoginInspetor: LogInViewControllerDelegate {
//
//    let model: CheckModel
//
//    init(model: CheckModel) {
//        self.model = model
//    }
//
//    func checkValue(login: String, password: String) -> User? {
//
//        let user = Checker.shared.user
//
//        let loginViewController = LogInViewController(model: model, loginHelper: loginHelper, loginCoordinator: loginCoordinator)
//        loginViewController.loginDelegate = self
//        _ = Checker.shared.checkLoginAndPassword(param: login, param: password)
//            if login == "1" && password == "2" {
//                return user
//            } else {
//                return nil
//            }
//    }
//
//}

//Фабрика п2: Вынесите генерацию LoginInspector из SceneDelegate (или AppDelegate) в фабрику: создайте объект MyLoginFactory (название на ваше усмотрение), подпишите на протокол.

//Мы хотим инкапсулировать логику создания делегата для LoginViewController, для этого мы описываем MyLoginFactory.

//Тут мы реализуем логику фабрики:

//MyLoginFactory должна подготовить объект (необходимый делегат для LoginViewController) до инициализации ViewController

//Делегат получается от фабрики MyLoginFactory (в этом случае мы имитируем решение, если нам надо иметь возможность что-то менять, не меняя саму структуру кода)
//class MyLoginFactory: LoginFactory {
//    
//    func checkLoginByFactory() -> LoginInspetor {
//        print("check login")
//        return LoginInspetor()
//    }
//}

enum AssetsColor: String {
    case background
    case buttoncolor
    case titlecolor
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}



