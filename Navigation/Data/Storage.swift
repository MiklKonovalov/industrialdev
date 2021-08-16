//
//  Storage.swift
//  Navigation
//
//  Created by Misha on 10.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage

struct Fasting {
    var autor: String
    var description: String
    var image: UIImage
    var numberOfLikes: Int
    var numberOfviews: Int
}

struct FastingSections {
    var fasting: [Fasting]
}

struct Images {
    var image: UIImage
    var secondImage: UIImage
    var thirdImage: UIImage
    var fourthImage: UIImage
    var title: String
    var arrow: String
}

struct PhotosSection {
    var imageArray: [Images]
}

struct Flow {
    
    static let sections = FastingSections(
            fasting: [
                Fasting(autor: "Gustav", description: "Today i did eat this", image: UIImage(named: "эко-мороженое 1")!, numberOfLikes: 100, numberOfviews: 100),
                Fasting(autor: "Dasha", description: "I love this watch", image: UIImage(named: "часы")!, numberOfLikes: 200, numberOfviews: 200),
                Fasting(autor: "Misha", description: "Playing rugby with my friends", image: UIImage(named: "регби")!, numberOfLikes: 300, numberOfviews: 300),
                Fasting(autor: "Nikita", description: "Soon...", image: UIImage(named: "cosmos")!, numberOfLikes: 400, numberOfviews: 400),
                    ]
                    )

    static let photos = PhotosSection(
            imageArray: [
                Images(image: UIImage(named: "регби")!, secondImage: UIImage(named: "cosmos")!, thirdImage: UIImage(named: "эко-мороженое 1")!, fourthImage: UIImage(named: "часы")!, title: "Photos", arrow: "\u{2192}"),
                        ]
                        )
    }

struct RugbyPhotos {
    var rugbyImage: UIImage
}

struct SectionOfRugbyPhotos {
    var imageArrayOfRugbyPhotos: [RugbyPhotos]
}

struct RugbyFlow {
    static let rugbySections = SectionOfRugbyPhotos(
        imageArrayOfRugbyPhotos: [
            RugbyPhotos(rugbyImage: UIImage(named: "1")!),
            RugbyPhotos(rugbyImage: UIImage(named: "2")!),
            RugbyPhotos(rugbyImage: UIImage(named: "3")!),
            RugbyPhotos(rugbyImage: UIImage(named: "4")!),
            RugbyPhotos(rugbyImage: UIImage(named: "5")!),
            RugbyPhotos(rugbyImage: UIImage(named: "6")!),
            RugbyPhotos(rugbyImage: UIImage(named: "7")!),
            RugbyPhotos(rugbyImage: UIImage(named: "8")!),
            RugbyPhotos(rugbyImage: UIImage(named: "9")!),
            RugbyPhotos(rugbyImage: UIImage(named: "10")!),
            RugbyPhotos(rugbyImage: UIImage(named: "11")!),
            RugbyPhotos(rugbyImage: UIImage(named: "12")!),
            RugbyPhotos(rugbyImage: UIImage(named: "13")!),
            RugbyPhotos(rugbyImage: UIImage(named: "14")!),
            RugbyPhotos(rugbyImage: UIImage(named: "15")!),
            RugbyPhotos(rugbyImage: UIImage(named: "16")!),
            RugbyPhotos(rugbyImage: UIImage(named: "17")!),
            RugbyPhotos(rugbyImage: UIImage(named: "18")!),
            RugbyPhotos(rugbyImage: UIImage(named: "19")!),
            RugbyPhotos(rugbyImage: UIImage(named: "20")!),
    ]
    )
}

//Добавить класс User для хранения информации о пользователе: полное имя, аватар, статус.
class User {
    var name: String
    var avatar: UIImage
    var status: String
    
    init(name: String, avatar: UIImage, status: String) {
        self.name = name
        self.avatar = avatar
        self.status = status
    }
    
}

//Добавить протокол UserService с функцией, которая принимает имя пользователя и возвращает объект класса User.
protocol UserService {
    
    func getUser(userName: String) -> User
    
}

//Добавить класс CurrentUserService, который поддерживает протокол UserService. Класс должен хранить объект класса User и возвращать его в реализации протокола, если переданное имя соответствует имени пользователя.

class CurrentUserService: UserService {
        
    var user: User
    
    func getUser(userName: String) -> User {
        if userName == user.name {
            return user
        }
        return user
    }
    
    init() {
        user = User(name: "Mike", avatar: UIImage(named: "gratis") ?? UIImage(), status: "work")
        }
    
}

//Добавить класс TestUserService, который поддерживает протокол UserService. Класс должен хранить объект класса User с тестовыми данными и возвращать его в реализации протокола.

class TestUserService: UserService {
    
    var user = User(name: "Test", avatar: UIImage(named: "gratis") ?? UIImage(), status: "Test")
    
    func getUser(userName: String) -> User {
        if userName == "Test" {
            return user
        }
        return user
    }
    
}






//Создаем сервис для проверки логина и пароля Checker или любым другим названием, у сервиса (это Singleton) будет 1 интерфейсный метод для проверки логина и пароля
class Checker {
    
    //создаём синглтон внутри себя. Статик так как создаём объект внутри объекта (Checker внутри Checker)
    static let shared = Checker()
    
    let user = User(name: "Регбист", avatar: UIImage(named: "регби") ?? UIImage(), status: "Бегу-бью!")
    
    func loadUser(completion: @escaping (User) -> Void) {
        DispatchQueue.global().async {
            // -оборачиваем в блок do функцию, которая может выбросить ошибку. try - попробуй вызвать. Если всё хорошо, то catch не вызовется
            do {
                let user = try self.fetchUser()
                DispatchQueue.main.async {
                    completion (user)
                }
            } catch LogInViewController.ApiError.unautorized {
                let viewModel = NextViewModel()
                let loginViewController = LogInViewController(model: viewModel as! SettingsViewOutput)
                let alertController = UIAlertController(title: "Пользователь не найден", message: "Проверьте логин", preferredStyle: .alert)
                loginViewController.present(alertController, animated: true, completion: nil)
            } catch {
                print("Что-то пошло не так")
            }
        }
    }
    
    private func fetchUser() throws -> User {
        if login == "1" && password == "2" {
            let user = self.user
            return (user)
        } else {
            throw LogInViewController.ApiError.unautorized
        }
    }
    
    //var user = User(name: "Регбист", avatar: UIImage(named: "регби") ?? UIImage(), status: "Бегу-бью!")
    
    private let login = "1"
    
    private let password = "2"
    
    //делаем приватный инициализатор, что бы нельзя было получить к нему доступ из вне
    private init() {
    
    }
    
    func checkLoginAndPassword(param log: String, param pass: String) -> User {
        if log == login && pass == password {
            return user
        } else {
            print("Wrong")
        }
        return user
    }
    
}





