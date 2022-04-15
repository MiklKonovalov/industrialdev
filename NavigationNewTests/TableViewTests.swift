//
//  TableViewTests.swift
//  NavigationNewTests
//
//  Created by Misha on 28.03.2022.
//

import XCTest
import UIKit
@testable import NavigationNew

class TableViewTests: XCTestCase {

    var tableView: UITableView!
    var sut: ProfileViewController!
    
    override func setUp() {
        sut = ProfileViewController(user: User(name: "Misha", avatar: UIImage(named: "регби") ?? UIImage(), status: "Я - новенький!"))
        sut.loadViewIfNeeded()
        
        tableView = sut.tableView
        tableView.dataSource = sut
    }

    override func tearDown() {
        
    }

    func test_number_of_sections_is_two() {
        let numberOfSections = tableView?.numberOfSections
        
        XCTAssertEqual(numberOfSections, 2)
    }

    func test_number_of_rows_in_one_sections() {
        let flow = Flow.sections
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), flow.fasting.count)
    }
    
    func test_cell_for_row_at_indexpath_returns_flow_cell() {
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is PhotosTableViewCell)
    }
    
    func test_cell_for_row_at_index_path_dequeues_cell_from_tablevie() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        
        mockTableView.register(FlowTableViewCell.self, forCellReuseIdentifier: String(describing: FlowTableViewCell.self))
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1))
        
        XCTAssertTrue(mockTableView.cellIsDequeued)
    }
    
    func test_cell_for_row_in_section_one_calls() {
        tableView.register(MockTaskCell.self, forCellReuseIdentifier: String(describing: FlowTableViewCell.self))
        
        let post = Flow.sections.fasting[0]
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockTaskCell
        
        //XCTAssertEqual(cell.post, post)
    }
    
}

extension TableViewTests {
    class MockTableView: UITableView {
        var cellIsDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class MockTaskCell : FlowTableViewCell {
        var post = Flow.sections.fasting[0]
        
    }
}

