//
//  APIClient.swift
//  TDDToDo
//
//  Created by Spencer Jones on 2/3/24.
//

import CoreLocation
import Foundation

protocol APIClientProtocol {
    func coordinate(for: String, completion: @escaping (Coordinate?) -> Void)
}

class APIClient: APIClientProtocol {
    
    lazy var geoCoder: GeoCoderProtocol = CLGeocoder()
    lazy var session: URLSessionProtocol = URLSession.shared
    
    func coordinate(for address: String, completion: @escaping (Coordinate?) -> Void) {
        geoCoder.geocodeAddressString(address) { placemarks, error in
            guard let clCoordinate = placemarks?.first?.location?.coordinate else {
                completion(nil)
                return
            }
            
            let coordinate = Coordinate(latitude: clCoordinate.latitude, longitude: clCoordinate.longitude)
            completion(coordinate)
        }
    }
    
    func toDoItems() async throws -> [ToDoItem] {
        guard let url = URL(string: "http://toodoo.app/items") else { return [] }
        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request, delegate: nil)
        let items = try JSONDecoder()
            .decode([ToDoItem].self, from: data)
        return items
    }
}

protocol GeoCoderProtocol {
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler)
}

extension CLGeocoder: GeoCoderProtocol {}

protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
