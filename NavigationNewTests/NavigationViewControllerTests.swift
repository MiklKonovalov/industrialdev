//
//  NavigationViewControllerTests.swift
//  NavigationNewTests
//
//  Created by Misha on 28.03.2022.
//

import UIKit
import XCTest
@testable import NavigationNew

class NavigationViewControllerTests: XCTestCase {

    let sut = ProfileViewController(user: User(name: "Misha", avatar: UIImage(named: "регби") ?? UIImage(), status: "Я - новенький!"))

    func test_table_view_not_nil_when_view_is_loaded() {
        
        _ = sut.view
        
        XCTAssertNotNil(sut.tableView)
    }
    
    

}
