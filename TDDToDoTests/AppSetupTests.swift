//
//  AppSetupTests.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 2/10/24.
//

import XCTest
@testable import TDDToDo

final class AppSetupTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_application_shouldSetupRoot() throws {
        let application = UIApplication.shared
        let scene = application.connectedScenes.first as? UIWindowScene
        let root = scene?.windows.first?.rootViewController
        
        let nav = try XCTUnwrap(root as? UINavigationController)
        XCTAssert(nav.topViewController is ToDoItemsListViewController)
    }

}
