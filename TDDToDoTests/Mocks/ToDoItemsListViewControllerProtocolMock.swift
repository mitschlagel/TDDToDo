//
//  ToDoItemsListViewControllerProtocolMock.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 1/22/24.
//

import Foundation
import UIKit
@testable import TDDToDo

class ToDoItemsListViewControllerProtocolMock: ToDoItemsListViewControllerProtocol {
    
    var selectToDoItemReceivedArguments: (viewController: UIViewController, item: ToDoItem)?
    
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem) {
        selectToDoItemReceivedArguments = (viewController, item)
        
    }
    
    var addToDoItemCallCount = 0
    func addToDoItem(_ viewController: UIViewController) {
        addToDoItemCallCount += 1
    }
}
