//
//  ToDoItemStoreProtocolMock.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 1/21/24.
//

import Combine
import Foundation
@testable import TDDToDo

class ToDoItemStoreProtocolMock: ToDoItemStoreProtocol {
    
    var itemPublisher = CurrentValueSubject<[ToDoItem], Never>([])
    
    var checkLastCallArgument: ToDoItem?
    
    func check(_ item: ToDoItem) {
        checkLastCallArgument = item
    }
}
