//
//  ToDoItemStoreTests.swift
//  ToDo-UIKitTests
//
//  Created by Spencer Jones on 1/20/24.
//

import Combine
import XCTest
@testable import ToDo_UIKit

final class ToDoItemStoreTests: XCTestCase {

    var sut: ToDoItemStore!
    
    override func setUpWithError() throws {
        sut = ToDoItemStore(fileName: "mock_store")
    }

    override func tearDownWithError() throws {
        sut = nil
        let url = FileManager.default.documentsURL(name: "mock_store")
        try? FileManager.default.removeItem(at: url)
    }
    
    func test_add_shouldPublishChange() throws {
        
        let toDoItem = ToDoItem(title: "foo")
        let receivedItems = try wait(for: sut.itemPublisher) {
            sut.add(toDoItem)
        }
        XCTAssertEqual(receivedItems, [toDoItem])
    }
    
    func test_check_shouldPublishChangeInDoneItems() throws {
        
        let toDoItem = ToDoItem(title: "foo")
        sut.add(toDoItem)
        sut.add(ToDoItem(title: "bar"))
        
        let receivedItems = try wait(for: sut.itemPublisher) {
            sut.check(toDoItem)
        }
        
        let doneItems = receivedItems.filter { $0.done }
        XCTAssertEqual(doneItems, [toDoItem] )
    }
    
    func test_init_shouldLoadPreviousToDoItems() throws {
        
        var sut1: ToDoItemStore? = ToDoItemStore(fileName: "mock_store")
        let publisherExpectation = expectation(description: "Wait for publisher in \(#file)")
        
        let toDoItem = ToDoItem(title: "Mock Title")
        sut1?.add(toDoItem)
        sut1 = nil
        let sut2 = ToDoItemStore(fileName: "mock_store")
        var result: [ToDoItem]?
        let token = sut2.itemPublisher
            .sink { value in
                result = value
                publisherExpectation.fulfill()
            }
        
        wait(for: [publisherExpectation], timeout: 1)
        token.cancel()
        XCTAssertEqual(result, [toDoItem])
    }
    
    func test_init_whenItemIsChecked_shouldLoadPreviousToDoItems() throws {
        var sut1: ToDoItemStore? = ToDoItemStore(fileName: "mock_store")
        let publisherExpectation = expectation(description: "Wait for publisher in \(#file)")
        
        let toDoItem = ToDoItem(title: "Mock Title")
        sut1?.add(toDoItem)
        sut1?.check(toDoItem)
        sut1 = nil
        let sut2 = ToDoItemStore(fileName: "mock_store")
        var result: [ToDoItem]?
        let token = sut2.itemPublisher
            .sink { value in
                result = value
                publisherExpectation.fulfill()
            }
        
        wait(for: [publisherExpectation], timeout: 1)
        token.cancel()
        XCTAssertEqual(result?.first?.done, true)
    }

}

extension XCTestCase {
    func wait<T: Publisher>(for publisher: T, afterChange change: () -> Void, file: StaticString = #file, line: UInt = #line) throws -> T.Output where T.Failure == Never {
        
        let publisherExpectation = expectation(description: "Wait for publisher in \(#file)")
        
        var result: T.Output?
        let token = publisher
            .dropFirst()
        // .sink Attaches a subscriber with closure-based behavior to a publisher that never fails.
            .sink { value in
                result = value
                publisherExpectation.fulfill()
            }
        
        change()
        wait(for: [publisherExpectation], timeout: 1)
        token.cancel()
        let unwrappedResult = try XCTUnwrap(result, "Publisher did not publish any value", file: file, line: line)
        return unwrappedResult
    }
}
