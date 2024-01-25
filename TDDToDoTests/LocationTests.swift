//
//  LocationTests.swift
//  ToDo-UIKitTests
//
//  Created by Spencer Jones on 1/19/24.
//

import XCTest
@testable import ToDo_UIKit

final class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_init_setsCoordinate() throws {
        let coord = Coordinate(latitude: 1, longitude: 2)
        let location = Location(name: "biz", coordinate: coord)
        
        let resultCoord = try XCTUnwrap(location.coordinate)
        
        XCTAssertEqual(resultCoord.latitude, 1, accuracy: 0.000_001)
        XCTAssertEqual(resultCoord.longitude, 2, accuracy: 0.000_001)
    }
    
    func test_init_setsName() {
        let location = Location(name: "batcave")
        XCTAssertEqual(location.name, "batcave")
    }

}
