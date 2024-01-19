//
//  ToDoItem.swift
//  ToDo-UIKit
//
//  Created by Spencer Jones on 1/19/24.
//

import Foundation

struct ToDoItem: Equatable {
    
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        lhs.title == rhs.title && lhs.timestamp == rhs.timestamp
    }
    
    
    let title: String
    let itemDescription: String?
    let timestamp: TimeInterval?
    let location: Location?
    
    init(title: String,
         itemDescription: String? = nil,
         timestamp: TimeInterval? = nil,
         location: Location? = nil) {
        
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}
