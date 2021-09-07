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
    
    struct NetworkService {
        
        private static let sharedSession = URLSession.shared
    
        static func dataTaskRequest(
            urlRequest: URLRequest,
            completion: @escaping (Data?) -> Void
        ) {
            let task = sharedSession.dataTask(
                with: urlRequest
            ) { data, response, error in

                guard error == nil else {
                    print("ERROR: \(error.debugDescription)")
                    return
                }

                if let httpResponse = response as? HTTPURLResponse, let data = data {
                    print("STATUS CODE: \(httpResponse.statusCode)")
                    print("HEADERS: \(httpResponse.allHeaderFields)")
                    print("DATA: \(data)")
                }
                completion(data)
            }
            task.resume()
        }
    }
    
    func receiveDate(appConfiguration: AppConfiguration, completion: @escaping (Data) -> Void) {
    
        //Формируем url
        
        switch appConfiguration {
        case .configureOne(let url):
            let request = URLRequest(url: url)
        case .configureTwo(let url):
            let request = URLRequest(url: url)
        case .configureThree(let url):
            let request = URLRequest(url: url)
            
        NetworkService.dataTaskRequest(urlRequest: request) { data in
            if let dataNew = data {
                print(String(data: dataNew, encoding: .utf8)!)
                completion(dataNew)
            }
        }
        }
    }
    
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


