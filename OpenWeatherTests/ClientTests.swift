//
//  OpenWeatherTests.swift
//  OpenWeatherTests
//
//  Created by C.Green on 22/10/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import XCTest
@testable import OpenWeather

class ClientTests: XCTestCase {
    
    private let defaultTimeout = 15.0
    var systemUnderTest: OWClient!

    override func setUp() {
        systemUnderTest = OWClient(configuration: .ephemeral)
    }

    override func tearDown() {
        systemUnderTest = nil
    }

    func testValidAPIConnection() {
        
        let request = OpenWeatherRequest.fiveDayForcast(city: "London", countryCode: "UK")
        let promise = expectation(description: "Valid API Connection")
        
        systemUnderTest.getWeather(from: request) { result in
            promise.fulfill()
        }
        
        waitForExpectations(timeout: defaultTimeout, handler: nil)
    }

    func testReceivedDataFromServer() {
        
        let request = OpenWeatherRequest.fiveDayForcast(city: "London", countryCode: "UK")
        let promise = expectation(description: "Received Data from API")
        var connectionResult: Result<Data, APIError>?
        
        systemUnderTest.getWeather(from: request) { result in
            connectionResult = result
            promise.fulfill()
        }
        
        waitForExpectations(timeout: defaultTimeout, handler: nil)
        
        guard let actualResult = connectionResult else { return XCTFail() }
        
        switch actualResult {
        case .success(_): break
        case .failure(let error): XCTFail(error.localizedDescription)
        }
    }
    
}
