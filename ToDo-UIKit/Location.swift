//
//  Location.swift
//  ToDo-UIKit
//
//  Created by Spencer Jones on 1/19/24.
//

import CoreLocation
import Foundation

struct Location {
    
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}
