//
//  ToDoItemsListViewController.swift
//  ToDo-UIKit
//
//  Created by Spencer Jones on 1/21/24.
//

import Combine
import UIKit

class ToDoItemsListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var toDoItemStore: ToDoItemStoreProtocol?
    private var items: [ToDoItem] = []
    private var token: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        token = toDoItemStore?.itemPublisher
            .sink(receiveValue: { [weak self] items in
                self?.items = items
            })
    
        tableView.register(ToDoItemCell.self, forCellReuseIdentifier: "ToDoItemCell")
    }
    
}

extension ToDoItemsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! ToDoItemCell
        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
        
        return cell
    }
}
