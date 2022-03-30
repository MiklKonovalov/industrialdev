//
//  NavigationNewTests.swift
//  NavigationNewTests
//
//  Created by Misha on 25.08.2021.
//

import XCTest
@testable import NavigationNew

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
