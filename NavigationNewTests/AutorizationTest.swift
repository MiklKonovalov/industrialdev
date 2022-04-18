//
//  AutorizationTest.swift
//  NavigationNewTests
//
//  Created by Misha on 13.04.2022.
//

import XCTest
@testable import NavigationNew

class AutorizationTest: XCTestCase {

    //Проверяем открытие контроллера с логином и паролем
    func testOpenLoginScreen() throws {
        let mainCoordinator = MainCoordinator()
        let viewController = mainCoordinator.configureLogIn()
        viewController.start()
        XCTAssertNotNil(viewController)
    }

}
