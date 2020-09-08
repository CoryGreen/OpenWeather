//
//  OpenWeatherTests.swift
//  OpenWeatherTests
//
//  Created by C.Green on 22/10/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import XCTest
@testable import OpenWeather

class RequestTests: XCTestCase {
    
    private let expectedURLComps = URLComponents(string: "https://api.openweathermap.org/data/2.5/forecast?appid=c92dcc692369a6eea28dcb9d0356c36a&q=London,UK")
    
    var systemUnderTest: OpenWeatherRequest!
    
    override func setUp() {
        
        // Given we create a request for a 5-day forcast for london
        systemUnderTest = OpenWeatherRequest.fiveDayForcast(city: "London", countryCode: "UK")
    }
    
    override func tearDown() {
        systemUnderTest = nil
    }

    func testFiveDataForcast_LondonUK_NonNilURLComps() {
        
        // When we get the URLComps
        let result = systemUnderTest.urlComponents
        
        // Then the URLComps should NOT be nil
        XCTAssertNotNil(result)
        
    }
    
    func testFiveDataForcast_LondonUK_NonNilURL() {
        
        // When we get the URL form the URLComps
        let result = systemUnderTest.urlComponents?.url
        
        // Then the URL should NOT be nil
        XCTAssertNotNil(result)
        
    }
    
    func testFiveDataForcast_LondonUK_ValidHost() {

        // When we get Post
        let sutHost = systemUnderTest.urlComponents?.host
        let expectedHost = expectedURLComps!.host!
        
        // Then when we comapre them
        let result = sutHost?.compare(expectedHost)
        
        // They should be the same
        XCTAssertEqual(result, ComparisonResult.orderedSame, "Invalid API Host")
        
    }
    
    func testFiveDataForcast_LondonUK_ValidPath() {

        // When we get the Path
        let sutPath = systemUnderTest.urlComponents?.path
        let expectedPath = expectedURLComps!.path
        
        // Then when we compare them
        let result = sutPath?.compare(expectedPath)
        
        // They should be the same
        XCTAssertEqual(result, ComparisonResult.orderedSame, "Invalid API Path")
        
    }

}
