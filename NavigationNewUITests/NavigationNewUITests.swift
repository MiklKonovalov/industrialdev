//
//  NavigationNewUITests.swift
//  NavigationNewUITests
//
//  Created by Misha on 25.08.2021.
//

import XCTest

class NavigationNewUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        //Поскольку выполнение тестов пользовательского интерфейса обходитcя дороже, обычно рекомендуется завершить работу, если произошел сбой.
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        //Мы отправляем аргумент командной строки нашему приложению, чтобы он могло сбросить свое состояние
        app.launchArguments.append("--uitesting")
    }
    
    //MARK: -Tests
    func testLogin() {
        let validPassword = "2"
        let validLogin = "1"
        
        //Запускаем приложение
        app.launch()
        
        app.tabBars.buttons.element(boundBy: 1).tap()
    
        let userNameTextField = app.textFields["Email or phone"]
        XCTAssertTrue(userNameTextField.exists)
        userNameTextField.tap()
        userNameTextField.typeText(validLogin)
        
        let passwordTextField = app.textFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText(validPassword)
        
        app.buttons["Login"].tap()
        
    }
}
