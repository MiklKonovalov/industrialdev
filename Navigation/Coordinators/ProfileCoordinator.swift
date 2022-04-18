//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Misha on 18.04.2022.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showProfileViewController()
    }
    
    func showProfileViewController() {
        let user = Checker.shared.user
        let profileViewController = ProfileViewController(user: user)
        self.navigationController.pushViewController(profileViewController, animated: true)
    }
    
}
