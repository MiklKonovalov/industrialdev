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
    let navigationController: UINavigationController

    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func pressButtonAndCheck() {

        do {
            
            let user = Checker.shared.user
            let profileViewController = ProfileViewController(user: user)
            let loginViewController = LogInViewController(loginCoordinator: self)
            guard let login = loginViewController.userNameTextField.text else { return }
            guard let password = loginViewController.passwordTextField.text else { return }
            _ = Checker.shared.checkLoginAndPassword(param: login , param: password)
            
            if login == "1" && password == "2" {
                self.navigationController.pushViewController(profileViewController, animated: true)
            } else {
                throw ValidationError.invalidValue
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}
