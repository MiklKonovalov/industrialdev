//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Misha on 25.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let tabBarController: TabBarController
    //Спомощью фабрики координатор будет публиковать контроллеры
    private let factory = ControllerFactoryImpl()
    
    init() {
        tabBarController = TabBarController()
        
        let feed = configureFeed()
        let logInCoordinator = configureLogIn()
        let photos = configurePhotosViewController()
        coordinators.append(feed)
        
        //В главном координаторе (MainCoordinator) запускаем дочерний координатор (FeedCoordinator)
        tabBarController.viewControllers = [feed.navigationController, logInCoordinator, photos]
        
        feed.start()
    }
    
    //Это дочерний координатор
    func configureFeed() -> FeedCoordinator {
        //Create TabTwo
        //Вынесли создание контроллера в отдельную фабрику "ControllerFactory"
        //Чтобы вернуть SettingsCoordinator его надо сначала инициализировать
        let navigationFeedViewController = UINavigationController()
        navigationFeedViewController.tabBarItem = UITabBarItem(
            title: "Folder",
            image: UIImage(systemName: "folder"),
            tag: 0)
        let coordinator = FeedCoordinator(navigation: navigationFeedViewController, factory: factory)
        
        return coordinator
    }
    
        func configureLogIn() -> UINavigationController {
            //Create TabOne
            let viewModel = CheckModel()
            let factory = ControllerFactoryImpl()
            let logInViewController = LogInViewController(model: viewModel)
            let navigationLoginViewController = UINavigationController(rootViewController: logInViewController)
            navigationLoginViewController.tabBarItem = UITabBarItem(
                title: "Profile",
                image: UIImage(systemName: "person.crop.circle"),
                tag: 1)
            return navigationLoginViewController
        }
        
        func configurePhotosViewController() -> UINavigationController {
            let photosViewController = PhotosViewController()
            photosViewController.title = "Photos"
            let navigationPhotosController = UINavigationController(rootViewController: photosViewController)
            navigationPhotosController.tabBarItem = UITabBarItem(
                title: "Photos",
                image: UIImage(systemName: "photo"),
                tag: 2)
            
            return navigationPhotosController
        }
    
    }
    

