//
//  DataParser.swift
//  OpenWeather
//
//  Created by C.Green on 22/10/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation

struct DataParser {
    
    /// A Generic parser to serialize JSON data into usbale objects model ojects
    ///
    /// - Parameters:
    ///   - data: the JSON data to parse
    ///   - type: The type to parse into, it MUST conform to the Decodable protocol
    /// - Returns: serialize model object
    /// - Throws: An error if any value throws an error during decoding.
    static func parse<T>(_ data: Data, type: T.Type) throws -> T where T : Decodable {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return try decoder.decode(T.self, from: data)
    }
    
}
