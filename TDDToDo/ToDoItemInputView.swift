//
//  ToDoItemInputView.swift
//  TDDToDo
//
//  Created by Spencer Jones on 2/2/24.
//

import SwiftUI

struct ToDoItemInputView: View {
    
    @ObservedObject var data: ToDoItemData
    
    var body: some View {
        VStack {
            TextField("Title", text: $data.title)
            Toggle("Add Date", isOn: $data.withDate)
            if data.withDate {
                DatePicker("Date", selection: $data.date)
            }
            TextField("Description",
                      text: $data.itemDescription)
            TextField("Location", text: $data.locationName)
            
        }
        
    }
}

struct ToDoItemInputView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemInputView(data: ToDoItemData())
    }
}
