//
//  ToDoItemStoreProtocolMock.swift
//  ToDo-UIKitTests
//
//  Created by Spencer Jones on 1/21/24.
//

import Combine
import Foundation
@testable import ToDo_UIKit

class ToDoItemStoreProtocolMock: ToDoItemStoreProtocol {
    
    var itemPublisher = CurrentValueSubject<[ToDoItem], Never>([])
    
    var checkLastCallArgument: ToDoItem?
    
    func check(_ item: ToDoItem) {
        checkLastCallArgument = item
    }
}
