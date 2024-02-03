//
//  ToDoItemInputView.swift
//  TDDToDo
//
//  Created by Spencer Jones on 2/2/24.
//

import SwiftUI

struct ToDoItemInputView: View {
    
    @ObservedObject var data: ToDoItemData
    var didAppear: ((Self) -> Void)?
    
    @State var withDate = false
    
    var body: some View {
        VStack {
            TextField("Title", text: $data.title)
            Toggle("Add Date", isOn: $withDate)
            if withDate {
                DatePicker("Date", selection: $data.date)
            }
            
        }
        .onAppear {
            self.didAppear?(self)
        }
        
    }
}

struct ToDoItemInputView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemInputView(data: ToDoItemData())
    }
}
