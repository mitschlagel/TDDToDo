//
//  ToDoItemStore.swift
//  ToDo-UIKit
//
//  Created by Spencer Jones on 1/20/24.
//

import Combine
import Foundation

class ToDoItemStore {
    
    var itemPublisher = CurrentValueSubject<[ToDoItem], Never>([]) //[ToDoItem] = what is sent, Never = the failure type
    
    private var items: [ToDoItem] = [] {
        didSet {
            itemPublisher.send(items)
        }
    }
    
    private let fileName: String
    
    init(fileName: String = "todoitems") {
        self.fileName = fileName
        loadItems()
    }
    
    func add(_ item: ToDoItem) {
        items.append(item)
        saveItems()
    }
    
    func check(_ item: ToDoItem) {
        var mutableItem = item
        mutableItem.done = true
        if let index = items.firstIndex(of: item) {
            items[index] = mutableItem
            saveItems()
        }
        
    }
    
    private func saveItems() {
        let url = FileManager.default.documentsURL(name: fileName)
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: url)
        } catch { // remember we get "let error" for free in a catch block
            print("error \(error)")
        }
    }
    
    private func loadItems() {
        let url = FileManager.default.documentsURL(name: fileName)
        do {
            let data = try Data(contentsOf: url)
            items = try JSONDecoder()
                .decode([ToDoItem].self, from: data)
        } catch {
            print("error: \(error)")
        }
    }
    
    
}
