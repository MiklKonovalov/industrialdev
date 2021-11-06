//
//  LogInViewController.swift
//  Navigation
//
//  Created by Misha on 06.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import RealmSwift
import Locksmith

//Протокол делегирования проверки логинаи пароля. Он имеет несколько параметров, данных для передачи обратно вызвавшему контроллеру. В данном случае я передаю обратно контроллеру логин и пароль.
protocol LogInViewControllerDelegate: AnyObject {
    //1.1 В методе делегата передаём экземпляр делегирующего объекта, чтобы вернуть результат работы
    func checkValue(login: String, password: String) -> User?

}

//Фабрика 1: Создайте protocol LoginFactory с 1 методом без параметров, который возвращает LoginInspector.
//Комментарий: Объявляем интерфейс, который будет играть роль «абстрактной фабрики»:
protocol LoginFactory {
    //Создаём фабричный метод (Фабричный метод - это метод, который что-то возвращает), который возвращает LoginInspector. Мы знаем, что фабрика должна проверять логин и пароль, по-этому, когда мы пишем общий интерфейс для фабрики, мы возвращаем LjginInspector. Интерфейс абстрактной фабрики содержит один метода: для проверки логина и пароля. Метод возвращает экземпляр общего базового класса? Таким образом, ограничивается область распространения знаний о конкретных типах пределами той области, в которой это действительно необходимо.
    func checkLoginByFactory() -> LoginInspetor
}


//REALM: 1. Создаём класс для создания модели
class UserList: Object {
    //1.1. Определяем свойства этой модели
    @objc dynamic var login: String = ""
    @objc dynamic var password: String = ""
    
    convenience init(login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }
 
    /*override static func primaryKey() -> String {
        return "id"
    }*/
}




class LogInViewController: UIViewController {
    
    var key = Data(count: 64)
    
    //Создаём экземпляр класса UserDefaults
    let defaults = UserDefaults.standard
    
    let brutForce = BrutForce()
    
    //1.2 Объявляем делегата для использования. В контроллере мы создаем instance протокола и называем его делегат
    var delegate: LogInViewControllerDelegate?
    
    var places: Results<UserList>!
    
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
        logoImageView.image = UIImage(named: "logo")
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
        let button = CustomButton(title: "Login", titleColor: .yellow ) {
            print("Custom Button Closure")
            self.logInButtonPressed()
        }
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pickUpPass: CustomButton = {
        let button = CustomButton(title: "Pick up", titleColor: .red ) {
            //self.generatePassword(passwordLength: 10)
        }
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
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
    
    private var model: SettingsViewOutput?
    
    init(model: SettingsViewOutput) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: FUNCTIONS
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
    
    
    //MARK: SELECTORS
    @objc private func logInButtonPressed() {
        //Проверяем, есть ли в БД значения
        let realm = try? Realm()
        let results = realm?.objects(UserList.self)
        print(results)
        if results != nil {
            //Загружаем ключ шифрования, чтобы расшифровать данные
            let dictionary = Locksmith.loadDataForUserAccount(userAccount: "QwertAccount")
            print("Dictionary is: \(dictionary)")
            guard userNameTextField.text == results?[0].login else { return }
            let user = User(name: "Realm", avatar: UIImage(named: "регби") ?? UIImage(), status: "Я авторизовался без ввода данных")
            let profileViewController = ProfileViewController(user: user)
            self.navigationController?.pushViewController(profileViewController, animated: true)
        } else {
            //Если в Keychain нет сохранённых данных, то сохраняем ввёдённые данные в поля логин и пароль
            
            //REALM: Создаём экземпляр класса модели
            let userOne = UserList()
            //REALM: Присваиваю значения свойствам
            userOne.login = userNameTextField.text ?? ""
            userOne.password = passwordTextField.text ?? ""
            //Создайм объект для доступа к базе данных
            do {
                //Генерируем ключ
                _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
                    SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!) }
                //Создаем конфигурацию для зашифрованной базы данных. Шифруем БД с ключом key
                let config = Realm.Configuration(encryptionKey: key)
                //Сохраняем ключ в Локсмит
                do {
                    try Locksmith.saveData(data: ["key" : key], forUserAccount: "QwertAccount")
                }
                catch {
                    print("Не удалось сохранть ключ")
                }
                //Получаем доступ к базе
                let realm = try Realm(configuration: config)
                //Сохраняем объект в базу
                DispatchQueue.main.async {
                    try! realm.write {
                        realm.add([userOne])
                    }
                }
            }
            catch {
                print(error)
            }
        }
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
    
    // MARK: Keyboard notifications
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        //Проверяем, есть ли ключ в Keychain
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "QwertAccount")
        if dictionary != nil {
            //Если ключ есть, то достаём его и читаем данные из БД
            print("There is key in Keychain")
            if let key = dictionary?["key"] {
                let config = Realm.Configuration(encryptionKey: key as? Data)
                do {
                    let realm = try Realm(configuration: config)
                    let results = realm.objects(UserList.self)
                    print("Пароли и явки: \(results)")
                }
                catch {
                    print("No realm")
                }
            } else {
                print("Can't find a key")
            }
        } else {
            //Если ключа нет, то предлагаем зарегистрироваться
            logInButton.setTitle("Sign In", for: .normal)
        }
        
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
class LoginInspetor: LogInViewControllerDelegate {

    func checkValue(login: String, password: String) -> User? {

        let user = Checker.shared.user

        _ = Checker.shared.checkLoginAndPassword(param: login, param: password)
            if login == "1" && password == "2" {
                return user
            } else {
                print("Login not correct")
            }
            return user
    }

}

//Фабрика п2: Вынесите генерацию LoginInspector из SceneDelegate (или AppDelegate) в фабрику: создайте объект MyLoginFactory (название на ваше усмотрение), подпишите на протокол.

//Мы хотим инкапсулировать логику создания делегата для LoginViewController, для этого мы описываем MyLoginFactory.

//Тут мы реализуем логику фабрики:

//MyLoginFactory должна подготовить объект (необходимый делегат для LoginViewController) до инициализации ViewController

//Делегат получается от фабрики MyLoginFactory (в этом случае мы имитируем решение, если нам надо иметь возможность что-то менять, не меняя саму структуру кода)
class MyLoginFactory: LoginFactory {
    
    func checkLoginByFactory() -> LoginInspetor {
        print("check login")
        return LoginInspetor()
    }
}

