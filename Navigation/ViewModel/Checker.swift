//
//  Checker.swift
//  Navigation
//
//  Created by Misha on 14.04.2022.
//

import Foundation
import UIKit

class Checker {
    
    static let shared = Checker()
    
    var user = User(name: "Регбист", avatar: UIImage(named: "регби") ?? UIImage(), status: "Бегу-бью!")
    
    let login = "1"
    
    let password = "2"
    
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
