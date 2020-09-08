//
//  DataParserTests.swift
//  OpenWeatherTests
//
//  Created by C.Green on 22/10/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import XCTest
@testable import OpenWeather

class DataParserTests: XCTestCase {
    
    var testBundle: Bundle!

    override func setUp() {
        testBundle = Bundle(for: type(of: self))
    }

    override func tearDown() {
        testBundle = nil
    }
    
    func testEmptyData_ParserThrowsException() {
        
        // Given empty data
        let emptyData = Data()
        
        // When we parse, an exception should be thrown
        XCTAssertThrowsError(try DataParser.parse(emptyData, type: APIResponse.self))
        
    }
    
    func testInavlidData_ParserThrowsException() {
        
        let invalidData = "Hello, world".data(using: .utf8)!
        
        XCTAssertThrowsError(try DataParser.parse(invalidData, type: APIResponse.self))
    }
    
    func testSampleData_ParserNoThrow() {
        
        let sampleDataPath = testBundle.path(forResource: "sampleResponse", ofType: "json")!
        let simpleData = try! Data(contentsOf: URL(fileURLWithPath: sampleDataPath))
        
        XCTAssertNoThrow(try DataParser.parse(simpleData, type: APIResponse.self))
    }
    
    func testSampleData_ParsedHasResults() {
        
        let sampleDataPath = testBundle.path(forResource: "sampleResponse", ofType: "json")!
        let simpleData = try! Data(contentsOf: URL(fileURLWithPath: sampleDataPath))
        let result = try! DataParser.parse(simpleData, type: APIResponse.self)
        
        let count = result.forcast.count
        
        XCTAssertGreaterThanOrEqual(count, 1)
    }

}
