//
//  ToDoItemsListViewControllerProtocolMock.swift
//  ToDo-UIKitTests
//
//  Created by Spencer Jones on 1/22/24.
//

import Foundation
import UIKit
@testable import ToDo_UIKit

class ToDoItemsListViewControllerProtocolMock: ToDoItemsListViewControllerProtocol {
    
    var selectToDoItemReceivedArguments: (viewController: UIViewController, item: ToDoItem)?
    
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem) {
        selectToDoItemReceivedArguments = (viewController, item)
        
    }
}
