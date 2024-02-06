//
//  APIClient.swift
//  TDDToDo
//
//  Created by Spencer Jones on 2/3/24.
//

import Foundation

protocol APIClientProtocol {
    func coordinate(for: String, completion: (Coordinate?) -> Void)
}

class APIClient: APIClientProtocol {
    func coordinate(for: String, completion: (Coordinate?) -> Void) {
        
    }
}
