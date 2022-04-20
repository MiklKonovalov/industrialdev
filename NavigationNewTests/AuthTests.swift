//
//  NavigationNewTests.swift
//  NavigationNewTests
//
//  Created by Misha on 25.08.2021.
//

import XCTest
@testable import NavigationNew

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

class NavigationNewTests: XCTestCase {

    var loginHelper: LoginHelperMock!
    var tableView: UITableView!
    
    override func setUp() {
        loginHelper = LoginHelperMock()
        super.setUp()
    }
    
    override func tearDown() {
        loginHelper = nil
        tableView = nil
        super.tearDown()
    }
    
    //Проверяем, действительное ли имя пользователя
    func test_is_valid_username() throws {
        XCTAssertNoThrow(try loginHelper?.validateUsername("1"))
    }
    
    func test_username_is_nil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try loginHelper.validateUsername(nil)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_username_is_long() throws {
        let expectedError = ValidationError.usernameTooLong
        var error: ValidationError?
        let username = "very long1"
        
        XCTAssertTrue(username.count == 10)
        
        XCTAssertThrowsError(try loginHelper.validateUsername(username)) {
            thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_init_user() {
        let user = User(name: "Misha", avatar: UIImage(named: "регби") ?? UIImage(), status: "Я - новенький!")
        
        XCTAssertNotNil(user)
    }
    
}
