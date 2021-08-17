//
//  ControllerFactory.swift
//  Navigation
//
//  Created by Misha on 24.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
//Создаём фабрику, которая будет импортировать контроллер
//Фабрика создаёт модули
//В фабрике создаём модуль и передаём координатору
protocol ControllerFactory {
    func makeFeed() -> (viewModel: CheckModel, controller: FeedViewController)
    func makeNext() -> (viewModel: NextViewModel, controller: NextController)
}

struct ControllerFactoryImpl: ControllerFactory {
    func makeNext() -> (viewModel: NextViewModel, controller: NextController) {
        let viewModel = NextViewModel()
        let controller = NextController(viewModel: viewModel)
        return (viewModel, controller)
    }
    
    
    func makeFeed() -> (viewModel: CheckModel, controller: FeedViewController) {
        let viewModel = CheckModel()
        let factory = ControllerFactoryImpl()
        let feedViewController = FeedViewController(viewModel: viewModel, factory: factory) { _ in
            
        }
        return (viewModel, feedViewController)
    }
    
}
