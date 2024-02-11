//
//  AppCoordinatorTests.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 2/10/24.
//

import XCTest
@testable import TDDToDo
import SwiftUI

final class AppCoordinatorTests: XCTestCase {
    
    var sut: AppCoordinator!
    var navigationControllerMock: NavigationControllerMock!
    var window: UIWindow!

    override func setUpWithError() throws {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        navigationControllerMock = NavigationControllerMock()
        sut = AppCoordinator(window: window, navigationController: navigationControllerMock, toDoItemStore: ToDoItemStore(fileName: "dummy_store"))
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationControllerMock = nil
        window = nil
        let url = FileManager.default.documentsURL(name: "dummy_store")
        try? FileManager.default.removeItem(at: url)
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
    
    func test_selectToDoItem_pushesDetails() throws {
        let dummyViewController = UIViewController()
        let item = ToDoItem(title: "fake title")
        
        sut.selectToDoItem(dummyViewController, item: item)
        
        let detail = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemDetailsViewController)
        
        XCTAssertEqual(detail.toDoItem, item)
    }
    
    func test_selectToDoItem_shouldSetItemStore() throws {
        let dummyViewController = UIViewController()
        let item = ToDoItem(title: "fake title")
        
        sut.selectToDoItem(dummyViewController, item: item)
        
        let detail = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemDetailsViewController)
        XCTAssertIdentical(detail.toDoItemStore as? ToDoItemStore, sut.toDoItemStore)
    }
    
    func test_addToDoItem_shouldPresentInputView() throws {
        let viewControllerMock = ViewControllerMock()
        
        sut.addToDoItem(viewControllerMock)
        
        let lastPresented = try XCTUnwrap(viewControllerMock.lastPresented as? UIHostingController<ToDoItemInputView>)
        XCTAssertIdentical(lastPresented.rootView.delegate as? AppCoordinator, sut)
    }
    
    func test_addToDoItemsWith_shouldCallToDoItemStore() throws {
        let toDoItemData = ToDoItemData()
        toDoItemData.title = "dummy title"
        
        let receivedItems = try wait(for: sut.toDoItemStore.itemPublisher, afterChange: {
            sut.addToDoItem(with: toDoItemData, coordinate: nil)
        })
        
        XCTAssertEqual(receivedItems.first?.title, toDoItemData.title)
    }
    
    func test_addToDoItemWith_shouldDismissInput() {
        let toDoItemData = ToDoItemData()
        toDoItemData.title = "fake title"
        
        sut.addToDoItem(with: toDoItemData, coordinate: nil)
        
        XCTAssertEqual(navigationControllerMock.dismissCallCount, 1)
    }



}
