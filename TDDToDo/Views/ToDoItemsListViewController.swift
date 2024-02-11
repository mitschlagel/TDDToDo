//
//  ToDoItemsListViewController.swift
//  TDDToDo
//
//  Created by Spencer Jones on 1/21/24.
//

import Combine
import UIKit

protocol ToDoItemsListViewControllerProtocol {
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem)
    func addToDoItem(_ viewController: UIViewController)
}

class ToDoItemsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var toDoItemStore: ToDoItemStoreProtocol?
    var delegate: ToDoItemsListViewControllerProtocol?
    
    private var dataSource: UITableViewDiffableDataSource<Section, ToDoItem>?
    private var items: [ToDoItem] = []
    private var token: AnyCancellable?
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = UITableViewDiffableDataSource<Section, ToDoItem>(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",
                                                     for: indexPath) as! ToDoItemCell
            
            cell.titleLabel.text = item.title
            if let timestamp = item.timestamp {
                let date = Date(timeIntervalSince1970: timestamp)
                cell.dateLabel.text = self?.dateFormatter.string(from: date)
            }
            return cell
            
        })
        
        token = toDoItemStore?.itemPublisher
            .sink(receiveValue: { [weak self] items in
                self?.items = items
                self?.update(with: items)
            })
    
        tableView.register(ToDoItemCell.self, forCellReuseIdentifier: "ToDoItemCell")
        tableView.delegate = self
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
        navigationItem.rightBarButtonItem = addItem
    }
    
    @objc func add(_ sender: UIBarButtonItem) {
        delegate?.addToDoItem(self)
    }
    
    private func update(with items: [ToDoItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ToDoItem>()
        snapshot.appendSections([.todo, .done])
        snapshot.appendItems(items.filter { false == $0.done}, toSection: .todo)
        snapshot.appendItems(items.filter { $0.done }, toSection: .done)
        dataSource?.apply(snapshot)
    }
    
    enum Section {
        case todo
        case done
    }
    
}

extension ToDoItemsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        delegate?.selectToDoItem(self, item: item)
    }
}
