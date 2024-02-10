//
//  ToDoItemDetailsViewController.swift
//  TDDToDo
//
//  Created by Spencer Jones on 1/24/24.
//

import MapKit
import UIKit

class ToDoItemDetailsViewController: UIViewController {

    let dateFormatter = DateFormatter()
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var doneButton: UIButton!
    
    var toDoItemStore: ToDoItemStoreProtocol?
    
    var toDoItem: ToDoItem? {
        didSet {
            titleLabel.text = toDoItem?.title
            dateLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: toDoItem?.timestamp ?? Date().timeIntervalSince1970))
            locationLabel.text = toDoItem?.location?.name
            descriptionLabel.text = toDoItem?.itemDescription
            
            if let coordinate = toDoItem?.location?.coordinate {
                mapView.setCenter(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), animated: false)
            }
            
            doneButton.isEnabled = (toDoItem?.done == false)
        }
    }
    
    
    @IBAction func checkItem(_ sender: UIButton) {
        if let toDoItem = toDoItem {
            toDoItemStore?.check(toDoItem)
        }
    }
    
}
