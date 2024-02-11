//
//  AppCoordinatorTests.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 2/10/24.
//

import XCTest
@testable import TDDToDo

final class AppCoordinatorTests: XCTestCase {
    
    var sut: AppCoordinator!
    var navigationControllerMock: NavigationControllerMock!
    var window: UIWindow!

    override func setUpWithError() throws {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        navigationControllerMock = NavigationControllerMock()
        sut = AppCoordinator(window: window, navigationController: navigationControllerMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationControllerMock = nil
        window = nil
    }
    
    func test_start_shouldSetDelegate() throws {
        sut.start()
        
        let listViewController = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemsListViewController)
        XCTAssertIdentical(listViewController.delegate as? AppCoordinator, sut)
    }
    
    func test_shouldAssignItemStore() throws {
        sut.start()
        
        let listViewController = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemsListViewController)
        XCTAssertNotNil(listViewController.toDoItemStore)
    }



}
