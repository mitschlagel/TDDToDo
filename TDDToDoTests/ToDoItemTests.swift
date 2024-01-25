//
//  ToDoItemTests.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 1/19/24.
//

import XCTest
@testable import TDDToDo

final class ToDoItemTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_init_whenGivenTitle_setsTitle() {
       
        let item = ToDoItem(title: "foo")
        
        XCTAssertEqual(item.title, "foo")
    }
    
    func test_init_whenGivenDescription_setsDescription() {
        
        let item = ToDoItem(title: "foo", itemDescription: "foo fighters")
        
        XCTAssertEqual(item.itemDescription, "foo fighters")
    }
    
    func test_init_setsTimestamp() throws {
        
        let mockTimeStamp: TimeInterval = 42.0
        let item = ToDoItem(title: "foo", timestamp: mockTimeStamp)
        let timestamp = try XCTUnwrap(item.timestamp)
        
        XCTAssertEqual(timestamp, mockTimeStamp, accuracy: 0.000_001)
    }
    
    func test_init_whenGivenLocation_setsLocation() {
        
        let mockLocation = Location(name: "foo place")
        let item = ToDoItem(title: "bar", location: mockLocation)
        
        XCTAssertEqual(item.location?.name, mockLocation.name)
    }
    
    func test_Equateable() {
        let itemA = ToDoItem(title: "foo")
        let itemB = ToDoItem(title: "bar")
        XCTAssertNotEqual(itemA, itemB)
    }
}


