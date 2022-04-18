//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Misha on 25.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    //Пустой массив координаторов
    var coordinators: [Coordinator] = []
    let tabBarController: TabBarController
    //Спомощью фабрики координатор будет публиковать контроллеры
    private let factory = ControllerFactoryImpl()
    let navigationController = UINavigationController()
    
    init() {
        tabBarController = TabBarController()
        
        let feed = configureFeed()
        let logInCoordinator = configureLogIn()
        let photos = configurePhotosController()
        coordinators.append(feed)
        
        //В главном координаторе (MainCoordinator) запускаем дочерний координатор (FeedCoordinator)
        tabBarController.viewControllers = [feed.navigationController, logInCoordinator.navigationController, photos]
        
        feed.start()
        logInCoordinator.start()
    }
    
        func configureLogIn() -> LoginCoordinator {
            let navigationLoginViewController = UINavigationController()
            navigationLoginViewController.tabBarItem = UITabBarItem(
                title: "display",
                image: UIImage(named: "display"),
                selectedImage: UIImage(named: "display"))
            let coordinator = LoginCoordinator(navigationController: navigationLoginViewController)
            return coordinator
        }
        
        //Это дочерний координатор
        func configureFeed() -> FeedCoordinator {
            //Create TabTwo
            //Вынесли создание контроллера в отдельную фабрику "ControllerFactory"
            //Чтобы вернуть SettingsCoordinator его надо сначала инициализировать
            let navigationFeedViewController = UINavigationController()
            navigationFeedViewController.tabBarItem = UITabBarItem(
                title: "Feed",
                image: UIImage(named: "keyboard"),
                selectedImage: UIImage(named: "keyboard"))
            let coordinator = FeedCoordinator(navigationController: navigationFeedViewController, factory: factory)
            
            return coordinator
        }
        
        func configurePhotosController() -> UINavigationController {
            let photosViewController = PhotosViewController()
            let navigationPhotosController = UINavigationController(rootViewController: photosViewController)
            navigationPhotosController.tabBarItem = UITabBarItem(
                title: "Photos",
                image: UIImage(named: "photo"),
                selectedImage: UIImage(named: "photo"))
            
            return navigationPhotosController
        }
    
    }
    

