//
//  ToDoItemCellTests.swift
//  ToDo-UIKitTests
//
//  Created by Spencer Jones on 1/21/24.
//

import XCTest
@testable import ToDo_UIKit

final class ToDoItemCellTests: XCTestCase {
    
    var sut: ToDoItemCell!
    
    override func setUpWithError() throws {
        sut = ToDoItemCell()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_hasTitleLabelSubview() {
        let subview = sut.titleLabel
        XCTAssertTrue(subview.isDescendant(of: sut.contentView))
    }
    
    func test_hasDateLabelSubview() {
        let subview = sut.dateLabel
        XCTAssertTrue(subview.isDescendant(of: sut.contentView))
    }
    
    func test_hasLocationLabelSubview() {
        let subview = sut.locationLabel
        XCTAssertTrue(subview.isDescendant(of: sut.contentView))
    }



}
