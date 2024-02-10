//
//  APIClientMock.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 2/3/24.
//

import Foundation
@testable import TDDToDo

class APIClientMock: APIClientProtocol {
    var coordinateAddress: String?
    var coordinateReturnValue: Coordinate?
    
    func coordinate(for address: String, completion: (Coordinate?) -> Void) {
        coordinateAddress = address
        completion(coordinateReturnValue)
    }
}
