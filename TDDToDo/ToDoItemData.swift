//
//  ToDoItemData.swift
//  TDDToDo
//
//  Created by Spencer Jones on 2/2/24.
//

import Foundation
import SwiftUI

class ToDoItemData: ObservableObject {
    @Published var title = ""
    @Published var date = Date()
    @Published var withDate = false
    @Published var itemDescription = ""
    @Published var locationName = ""
}
