//
//  ToDoItemInputViewDelegateMock.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 2/5/24.
//

import Foundation
@testable import TDDToDo

class ToDoItemInputViewDelegateMock: ToDoItemInputViewDelegate {

    var lastToDoItemData: ToDoItemData?
    var lastCoordinate: Coordinate?
    
    func addToDoItem(with data: ToDoItemData, coordinate: Coordinate?) {
        lastToDoItemData = data
        lastCoordinate = coordinate
        
    }

}
