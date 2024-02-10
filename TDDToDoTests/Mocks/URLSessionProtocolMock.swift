//
//  URLSessionProtocolMock.swift
//  TDDToDoTests
//
//  Created by Spencer Jones on 2/9/24.
//

import Foundation
@testable import TDDToDo

class URLSessionProtocolMock: URLSessionProtocol {
    var dataForDelegateReturnValue: (Data, URLResponse)?
    var dataForDelegateRequest: URLRequest?
    var dataForDelegateError: Error?
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws ->
    (Data, URLResponse) {
        
        if let error = dataForDelegateError {
            throw error
        }
        dataForDelegateRequest = request
        guard let dataForDelegateReturnValue = dataForDelegateReturnValue else {
            fatalError()
        }
        return dataForDelegateReturnValue
    }
}
