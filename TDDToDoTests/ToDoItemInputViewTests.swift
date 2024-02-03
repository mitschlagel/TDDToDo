//
//  ToDoItemInputViewTests.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 2/2/24.
//

import XCTest
import ViewInspector
@testable import TDDToDo

extension ToDoItemInputView: Inspectable {}

final class ToDoItemInputViewTests: XCTestCase {
    
    var sut: ToDoItemInputView!
    var toDoItemData: ToDoItemData!

    override func setUpWithError() throws {
        toDoItemData = ToDoItemData()
        sut = ToDoItemInputView(data: toDoItemData)
    }

    override func tearDownWithError() throws {
        sut = nil
        toDoItemData = nil
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
    func whenWithDate_shouldAllowDateInput() throws {
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
                return label == "Location"
            })
            .setInput(expected)
        let input = toDoItemData.locationName
        XCTAssertEqual(input, expected)
    }


}
