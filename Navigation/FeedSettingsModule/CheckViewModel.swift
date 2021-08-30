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
        ) throws {
            let task = sharedSession.dataTask(
                with: urlRequest
            ) { data, response, error in
               
                guard error == nil else {
                    print("ERROR: \(error.debugDescription)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("STATUS: \(httpResponse.statusCode)")
            }
                completion(data)
        }
            task.resume()
    }
        
        static func dataTask(
            url: URL,
            completion: @escaping (String?) -> Void
        ) {
            let task = sharedSession.dataTask(
                with: url
            ) { data, response, error in
                
                guard error == nil else {
                    print(error.debugDescription)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
                print(httpResponse.statusCode)
                print(httpResponse.allHeaderFields as! [String: Any])
                
                if let data = data {
                    completion(String(data: data, encoding: .utf8))
                }
            }
            
            task.resume()
        }
    }
    //***JSONSerialization***
    func getRequest(completion: ((String) -> Void)?) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            guard let response = response, let data = data else { return }
            
            print(response)
            print(data)
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
                
                let net = Net(json: json)
                
                completion?(net.title)
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
    //***JSON Decodable***
    func receiveData(completion: ((String) -> Void)?) {
        
        let request = URLRequest(url: URL(string: Constants.localURL)!)
        
        try! NetworkService.dataTaskRequest(urlRequest: request) { string in
            if let json = string {
                do {
                    let result = try JSONDecoder().decode(
                        Planet.self,
                        from: json
                    )
                    completion?(result.orbital)
                } catch {
                    print(String(describing: error))
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
