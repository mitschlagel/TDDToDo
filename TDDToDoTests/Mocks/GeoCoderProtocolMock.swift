//
//  GeoCoderProtocolMock.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 2/8/24.
//

import CoreLocation
import Foundation
@testable import TDDToDo

class GeoCoderProtocolMock: GeoCoderProtocol {
    var geocodeAddressString: String?
    var completionHandler: CLGeocodeCompletionHandler?
    
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
        geocodeAddressString = addressString
        self.completionHandler = completionHandler
    }
}
