//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Misha on 14.04.2022.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let viewModel = CheckModel()
    let navigationController: UINavigationController
    var profileCoordinator: ProfileCoordinator?
    private var output: (() -> Void)?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        showLoginViewController()
    }
    
    private func showLoginViewController() {
        let loginViewController = LogInViewController(model: viewModel)
        
        loginViewController.output = { action in
            switch action {
            case .success:
                self.profileCoordinator = ProfileCoordinator(navigationController: self.navigationController)
                self.profileCoordinator?.start()
            case .invalid:
                print("Invalid Login or Password")
            }
        }
        self.navigationController.pushViewController(loginViewController, animated: true)
    }
    
}
