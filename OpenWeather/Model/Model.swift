//
//  Model.swift
//  OpenWeather
//
//  Created by C.Green on 22/10/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation

struct APIResponse: Codable {
    
    var code: String
    var count: Int
    var forcast: [WeatherInformation]
    var city: City
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case count = "cnt"
        case forcast = "list"
        case city
    }
    
}

struct City: Codable {
    
    var id: Int
    var name: String
    var country: String
}

struct WeatherValues: Codable {
    
    var temperature: Double
    var temperatureMax: Double
    var temperatureMin: Double
    var pressure: Double
    var seaLevel: Double
    var groundLevel: Double
    var humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity
        
    }
}

struct WeatherInformation: Codable {
    
    var weather: [WeatherCondition]
    var main: WeatherValues
    var time: Date
    
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case time = "dt"
    }
    
}

struct WeatherCondition: Codable {
    
    var id: Int
    var main: String
    var desc: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case desc = "description"
        case icon
    }
    
}
