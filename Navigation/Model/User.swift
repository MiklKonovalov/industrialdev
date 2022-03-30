//
//  User.swift
//  Navigation
//
//  Created by Misha on 28.03.2022.
//

import Foundation
import UIKit

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
