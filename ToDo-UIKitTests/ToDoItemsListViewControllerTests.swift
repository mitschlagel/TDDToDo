//
//  ToDoItemsListViewControllerTests.swift
//  ToDo-UIKitTests
//
//  Created by Spencer Jones on 1/21/24.
//

import XCTest
@testable import ToDo_UIKit

final class ToDoItemsListViewControllerTests: XCTestCase {

    var sut: ToDoItemsListViewController!
    var toDoItemStoreMock: ToDoItemStoreProtocolMock!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = try XCTUnwrap(storyboard.instantiateInitialViewController() as? ToDoItemsListViewController)
        toDoItemStoreMock = ToDoItemStoreProtocolMock()
        sut.toDoItemStore = toDoItemStoreMock
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_shouldBeSetup() {
        XCTAssertNotNil(sut)
    }
    
    func test_shouldHaveTableView() {
        XCTAssertTrue(sut.tableView.isDescendant(of: sut.view))
    }
    
    func test_numberOfRos_whenOneItemIsSent_shouldReturnOne() {
        toDoItemStoreMock.itemPublisher
            .send([ToDoItem(title: "foo 1")])
        
        let result = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(result, 1)
    }
    
    func test_numberOfRows_whenTwoItemsAreSent_shouldReturnTwo() {
        toDoItemStoreMock.itemPublisher
            .send([
                ToDoItem(title: "foo 1"),
                ToDoItem(title: "foo 2")
            ])
        
        let result = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(result, 2)
    }
    
    func test_cellForRowAt_shouldReturnCellWithTitle() throws {
        let titleUnderTest = "mock 1"
        toDoItemStoreMock.itemPublisher
            .send([ToDoItem(title: titleUnderTest)])
        let tableView = try XCTUnwrap(sut.tableView)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = try XCTUnwrap(tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath)) as? ToDoItemCell
        XCTAssertEqual(cell?.titleLabel.text, titleUnderTest)
    }
    
    func test_cellForRowAt_shouldReturnCellWithTitle2() throws {
        let titleUnderTest = "mock 2"
        toDoItemStoreMock.itemPublisher
            .send([
                ToDoItem(title: "mock 1"),
                ToDoItem(title: titleUnderTest)
            ])
        let tableView = try XCTUnwrap(sut.tableView)
        
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = try XCTUnwrap(
            tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as? ToDoItemCell
        )
        XCTAssertEqual(cell.titleLabel.text, titleUnderTest)
    }
    
}