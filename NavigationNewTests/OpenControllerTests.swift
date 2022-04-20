//
//  AutorizationTest.swift
//  NavigationNewTests
//
//  Created by Misha on 13.04.2022.
//

import XCTest
@testable import NavigationNew

class LoginViewControllerMock {
    func checkValue(login: String, password: String) -> Bool {
        if login == "1" && password == "2" {
            return true
        } else {
            return false
        }
    }
}

class AutorizationTest: XCTestCase {

    //Проверяем открытие контроллера с логином и паролем
    func testOpenLoginScreen() throws {
        let mainCoordinator = MainCoordinator()
        let loginViewController = mainCoordinator.configureLogIn()
        loginViewController.start()
        XCTAssertNotNil(loginViewController)
    }
    
    //Проверяем проверку логина и пароля
    func testLoginAndPassworsCheck() throws {
        let loginViewControllerMock = LoginViewControllerMock()
        let checker = Checker.shared
        let result = loginViewControllerMock.checkValue(login: checker.login, password: checker.password)
        XCTAssertTrue(result)
    }

    //Проверяем открытие контроллера с профилем
    func testOpenProfileScreen() {
        let mainCoordinator = MainCoordinator()
        let loginVoordinator = mainCoordinator.configureLogIn()
        let profileViewController = loginVoordinator.start()
        XCTAssertNotNil(profileViewController)
    }
    
}
