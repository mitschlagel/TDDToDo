//
//  ToDoItemInputView.swift
//  TDDToDo
//
//  Created by Spencer Jones on 2/2/24.
//

import SwiftUI

struct ToDoItemInputView: View {
    
    @ObservedObject var data: ToDoItemData
    var delegate: ToDoItemInputViewDelegate?
    let apiClient: APIClientProtocol
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $data.title)
                Toggle("Add Date", isOn: $data.withDate)
                if data.withDate {
                    DatePicker("Date", selection: $data.date)
                }
                TextField("Description",
                          text: $data.itemDescription)
            }
            Section {
                TextField("Location Name", text: $data.locationName)
                TextField("Address", text: $data.addressString)
            }
            Section {
                Button(action: {
                    addToDoItem()
                }, label: {
                    Text("Save")
                })
            }
        }
        
    }
    
    func addToDoItem() {
        if false == data.addressString.isEmpty {
            apiClient.coordinate(for: data.addressString, completion: { coordinate in
                self.delegate?.addToDoItem(with: data, coordinate: coordinate)
            })
        } else {
            delegate?.addToDoItem(with: data, coordinate: nil)
        }
        
    }
}

protocol ToDoItemInputViewDelegate {
    func addToDoItem(with data: ToDoItemData, coordinate: Coordinate?)
}

struct ToDoItemInputView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemInputView(data: ToDoItemData(), apiClient: APIClient())
    }
}
