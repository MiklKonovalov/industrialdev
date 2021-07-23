//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    //Внедрите зависимость контроллера от LoginInspector, то есть присвойте значение свойству делегата в SceneDelegate или AppDelegate

    //Фабрика п3: Инициализируйте в SceneDelegate / AppDelegate только фабрику .
    let myLoginFactory = MyLoginFactory()
    
//    init(model: ModelInput) {
//        self.model = model
//    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        //Создаём UIWindow используя
//        let window = UIWindow(windowScene: windowScene)
//        //
//        let model  = CheckModel()
//        //Создаём программно новую иерархию вью
//        //let loginViewController = LogInViewController(model: model)
//        let loginViewController = FeedViewController(model: model) {_ in
//            
//        }
//        
//        let navigationController = UINavigationController(rootViewController: loginViewController)
//        //Устанавливаем главный вью контроллер окну с нашим вью контроллером
//        window.rootViewController = navigationController
//        
//        self.window = window
//        window.makeKeyAndVisible()
//        
//        //loginViewController.delegate = myLoginFactory.checkLoginByFactory()

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

