//
//  SettingsCoordinator.swift
//  Navigation
//
//  Created by Misha on 26.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
// Координатор занимается навигацией
//SettingsCoordinator будет отвечать за создание модуля SettingsViewModel
final class FeedCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    //Передаём SettingsCoordinator navigationController при помощи инициализатора
    let navigationController: UINavigationController
    
    //Передаём фабрику как зависимость в дочернии координаторы
    private let factory: ControllerFactory
    private lazy var feedModule = {
        factory.makeFeed()
    }()
    
    init(navigation: UINavigationController, factory: ControllerFactory) {
        self.navigationController = navigation
        self.factory = factory
    }
    
    func start() {
        //обратная связь SettingsModule
        //координатор знает о вью моделе
        feedModule.viewModel.onShowNext = { [weak self] in
            guard let controller = self?.configureNext() else { return }
            self?.navigationController.pushViewController(controller, animated: true)
        }
        navigationController.pushViewController(feedModule.controller, animated: true)
    }
    
    //Конфигурация NextModule
    private func configureNext() -> NextController {
        return factory.makeNext().controller
    }
}
