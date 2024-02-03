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
    
    func test_titleInput_shouldSetValueInData() throws {
        let expected = "foo title"
        try sut
            .inspect()
            .find(ViewType.TextField.self)
            .setInput(expected)
        
        let input = toDoItemData.title
        
        XCTAssertEqual(input, expected)
    }
    
    func test_whenWithoutDate_shouldNotShowDateInput() {
        XCTAssertThrowsError(try sut
            .inspect()
            .find(ViewType.DatePicker.self))
    }
    
    func test_whenWithDate_shouldAllowDateInput() throws {
        let exp = sut.on(\.didAppear) { view in
            try view.find(ViewType.Toggle.self).tap()
            
            let expected = Date(timeIntervalSinceNow: 1_000_000)
            try view
                .find(ViewType.DatePicker.self)
                .select(date: expected)
        
            let input = self.toDoItemData.date
            XCTAssertEqual(input, expected)
        }
        
        ViewHosting.host(view: sut) // This is what renders the view and makes working with @State possible
        wait(for: [exp], timeout: 0.1)
    }


}
