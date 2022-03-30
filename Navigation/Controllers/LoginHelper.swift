//
//  LoginHelper.swift
//  Navigation
//
//  Created by Misha on 23.03.2022.
//

import Foundation
import UIKit

protocol LoginPresenter {
    func validateUsername(_ username: String?) throws -> String
    func validatePassword(_ password: String?) throws -> String
}

struct LoginHelperMock: LoginPresenter {
    
    func validateUsername(_ username: String?) throws -> String {
        guard let username = username else { throw ValidationError.invalidValue }
        guard username.count < 10 else { throw ValidationError.usernameTooLong}
        return username
    }
    
    func validatePassword(_ password: String?) throws -> String {
        guard let password = password else { throw ValidationError.invalidValue }
        guard password.count < 10 else { throw ValidationError.passwordTooLong}
        return password
    }
}

enum ValidationError: LocalizedError {
    case invalidValue
    case passwordTooLong
    case usernameTooLong
    
    var errorDescription: String? {
        switch self {
        case .invalidValue:
            return "Invalid value"
        case .usernameTooLong:
            return "Username too long"
        case .passwordTooLong:
            return "Password too long"
        }
    }
}
