//
//  ViewModels.swift
//  Navigation
//
//  Created by Misha on 02.09.2021.
//

import Foundation
import UIKit
import Firebase

public class UserViewModel {
    
    private let user: User
    
    public init(user: User) {
        self.user = user
    }
    
    public var name: String {
        return user.name
    }
    
    public var avatar: UIImage {
        return user.avatar
    }
    
    public var status: String {
        return user.status
    }
    
}
