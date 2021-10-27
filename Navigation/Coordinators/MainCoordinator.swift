//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Misha on 25.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    let tabBarController: TabBarController
    var coordinators: [Coordinator] = []

    //Спомощью фабрики координатор будет публиковать контроллеры
    private let factory = ControllerFactoryImpl()
    
    init() {
        tabBarController = TabBarController()
        
        let feed = configureFeed()
        let logInCoordinator = configureLogIn()
        let photos = configurePhotosController()
        let likePosts = configureLikePostsController()
        coordinators.append(feed)
        
        //В главном координаторе (MainCoordinator) запускаем дочерний координатор (FeedCoordinator)
        tabBarController.viewControllers = [feed.navigationController, logInCoordinator, photos, likePosts]
        
        feed.start()
    }
    
        func configureLogIn() -> UINavigationController {
            //Create TabOne
            let viewModel = CheckModel()
            let factory = ControllerFactoryImpl()
            let logInViewController = LogInViewController(model: viewModel)
            let navigationLoginViewController = UINavigationController(rootViewController: logInViewController)
            navigationLoginViewController.tabBarItem = UITabBarItem(
                title: "display",
                image: UIImage(named: "display"),
                selectedImage: UIImage(named: "display"))
            return navigationLoginViewController
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
            let coordinator = FeedCoordinator(navigation: navigationFeedViewController, factory: factory)
            
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
    
        func configureLikePostsController() -> UINavigationController {
            
            let likePostsViewController = LikePostsViewController()
            let navigationLikePostsController = UINavigationController(rootViewController: likePostsViewController)
            navigationLikePostsController.tabBarItem = UITabBarItem(
                title: "Like",
                image: UIImage(),
                selectedImage: UIImage())
            return navigationLikePostsController
        }
    
}
