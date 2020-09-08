//
//  AppDelegate.swift
//  OpenWeather
//
//  Created by C.Green on 22/10/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queries: [URLQueryItem] { get }
}
extension Endpoint {
    
    var urlComponents: URLComponents? {
        
        guard var components = URLComponents(string: base)  else { return nil }
        components.path = path
        components.queryItems = queries
        return components
    }
    
    var request: URLRequest? {
        guard let url = urlComponents?.url else { return nil }
        return URLRequest(url: url)
    }
}

//b6907d289e10d714a6e88b30761fae22

enum OpenWeatherRequest {
    case fiveDayForcast(city: String, countryCode: String)
}

extension OpenWeatherRequest: Endpoint {
    
    var base: String {
        return "https://api.openweathermap.org"
    }
    
    var queries: [URLQueryItem] {
        
        var params = [URLQueryItem(name: "appid", value: "c92dcc692369a6eea28dcb9d0356c36a")]
        
        switch self {
        case .fiveDayForcast(let city, let countryCode):
            params.append(URLQueryItem(name: "q", value: "\(city),\(countryCode)"))
        
        }
        
        return params
        
    }
    
    var path: String {
        switch self {
        case .fiveDayForcast(_, _): return "/data/2.5/forecast"
        }
    }
    
}
