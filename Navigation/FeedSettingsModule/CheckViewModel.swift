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
//Модель занимается данными

//Внедряем зависимость через Протокол
protocol SettingsViewOutput {
    var onTapShowNextModel: () -> Void { get }
    func check(word: String, completion: (Bool) -> Void)
    
}

//MVVM: часть модуля - ViewModel

//-Принимает входные данные модуля
//-Обрабатывает входные данные
//-Ждет от View(контроллера) запросов
//-Принимает исходящие от View события и данные
//-Обрабатывает, отдает исходящие данные модуля

//Модель проверяет слово и отправляет ответ: верно/не верно
class CheckModel: SettingsViewOutput {
    
    //интерфейс для отправки данных в координатор
    var onShowNext: (() -> Void)?
    
    //интерфейс для приёма данных от вью контроллера
    lazy var onTapShowNextModel: () -> Void = { [weak self] in
        self?.onShowNext?()
    }
    
    var password = "Key"
    
    //Вью модель трансформирует данные
    func check(word: String, completion: (Bool) -> Void) {
        completion(word == password)
    }

}
