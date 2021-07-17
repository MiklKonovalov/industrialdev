//
//  SettingsModel.swift
//  Navigation
//
//  Created by Misha on 14.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

//Модель определяет то, что может отображаться. UI отсутствует.

//Внедряем зависимость через Протокол
protocol ModelInput {
    func check(word: String) -> String
    
}

//Модель проверяет слово и отправляет ответ: верно/не верно
struct CheckModel: ModelInput {
    
    var titleModel: String
    var titleColorModel: UIColor
    var password = "Пароль-король!"
    
    func check(word: String) -> String {
        if word == password {
            return("true")
        } else {
            return("false")
        }
    }

}
