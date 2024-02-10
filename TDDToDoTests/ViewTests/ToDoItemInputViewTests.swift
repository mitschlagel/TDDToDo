//
//  ToDoItemInputViewTests.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 2/2/24.
//

import XCTest
import ViewInspector
@testable import TDDToDo

final class ToDoItemInputViewTests: XCTestCase {
    
    var sut: ToDoItemInputView!
    var toDoItemData: ToDoItemData!
    var apiClientMock: APIClientMock!

    override func setUpWithError() throws {
        apiClientMock = APIClientMock()
        toDoItemData = ToDoItemData()
        sut = ToDoItemInputView(data: toDoItemData, apiClient: apiClientMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        toDoItemData = nil
        apiClientMock = nil
    }
    
    func test_titleInput_shouldAllowTitleInput() throws {
        let expected = "foo title"
        try sut
            .inspect()
            .find(ViewType.TextField.self,
                  where: { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Title"
            })
            .setInput(expected)
        
        let input = toDoItemData.title
        
        XCTAssertEqual(input, expected)
    }
    
    func test_whenWithoutDate_shouldNotShowDateInput() {
        XCTAssertThrowsError(try sut
            .inspect()
            .find(ViewType.DatePicker.self))
    }
    
    // Toggle.tap() unavailable >= iOS16
    func x_test_whenWithDate_shouldAllowDateInput() throws {
        let expected = Date()
        try sut.inspect().find(ViewType.Toggle.self).tap()
        try sut
            .inspect()
            .find(ViewType.DatePicker.self)
            .select(date: expected)
        
        let input = self.toDoItemData.date
        XCTAssertEqual(input, expected)
    }
    
    func test_shouldAllowDescriptionInput() throws {
        let expected = "foo description"
        try sut
            .inspect()
            .find(ViewType.TextField.self,
                  where: { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Description"
            })
            .setInput(expected)
        
        let input = toDoItemData.itemDescription
        XCTAssertEqual(input, expected)
    }
    
    func test_shouldAllowLocationNameInput() throws {
        let expected = "foo location"
        try sut
            .inspect()
            .find(ViewType.TextField.self,
                  where: { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Location Name"
            })
            .setInput(expected)
        let input = toDoItemData.locationName
        XCTAssertEqual(input, expected)
    }
    
    func shouldHaveASaveButton() throws {
        XCTAssertNoThrow(try sut
            .inspect()
            .find(ViewType.Button.self,
                  where: { view in
            let label = try view
                .labelView()
                .text()
                .string()
            return label == "Save"
        }))
    }
    
    func test_saveButton_shouldFetchCoordinate() throws {
        toDoItemData.title = "mock title"
        let expected = "mock address"
        toDoItemData.addressString = expected
        
        try sut
            .inspect()
            .find(ViewType.Button.self,
                  where: { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Save"
            })
            .tap()
        
        XCTAssertEqual(apiClientMock.coordinateAddress, expected)
    }
    
    func test_save_whenAddressEmpty_shouldNotFetchCoordinate() throws {
        toDoItemData.title = "foo title"
        
        
        try sut
            .inspect()
            .find(ViewType.Button.self,
                  where: { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Save"
            })
            .tap()
        
        XCTAssertNil(apiClientMock.coordinateAddress)
    }
    
    func test_save_shouldCallDelegate() throws {
        toDoItemData.title = "foo title"
        toDoItemData.addressString = "foo address"
        apiClientMock.coordinateReturnValue = Coordinate(latitude: 1, longitude: 2)
        let delegateMock = ToDoItemInputViewDelegateMock()
        sut.delegate = delegateMock
        
        try sut.tapButtonWith(name: "Save")
        
        XCTAssertEqual(delegateMock.lastToDoItemData?.title, "foo title")
        XCTAssertEqual(delegateMock.lastCoordinate?.latitude, 1)
        XCTAssertEqual(delegateMock.lastCoordinate?.longitude, 2)
    }
    
    func test_save_whenAddressEmpty_shouldCallDelegate() throws {
        toDoItemData.title = "foo title"
        apiClientMock.coordinateReturnValue = Coordinate(latitude: 1, longitude: 2)
        let delegateMock = ToDoItemInputViewDelegateMock()
        sut.delegate = delegateMock
        
        try sut.tapButtonWith(name: "Save")
        
        XCTAssertEqual(delegateMock.lastToDoItemData?.title, "foo title")
    }
}

extension ToDoItemInputView {
    func tapButtonWith(name: String) throws {
        try inspect()
            .find(ViewType.Button.self,
                  where: { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == name
            })
            .tap()
    }
}
