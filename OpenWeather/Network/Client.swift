//
//  AppDelegate.swift
//  OpenWeather
//
//  Created by C.Green on 22/10/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation

// An ENUM to represent the return state from the API
enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}

// A list of possible errors, to be used with the ENUMs above
enum APIError: Error {
    
    case requestFailed
    case invalidRequest
    case invalidData
    case responseUnsuccessful
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidRequest: return "Invalid Request"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        }
    }
}

// A simpel protocol for a simple client
protocol APIClient {
    
    var session: URLSession { get }
    func fetch(with request: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void)
    
}

// An extension to the client to simply fetch
extension APIClient {
    
    func fetch(with request: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void) {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return completion(.failure(.requestFailed)) }
            
            if httpResponse.statusCode != 200 { return completion(.failure(.responseUnsuccessful)) }
            
            guard let data = data else { return completion(.failure(.invalidData)) }
            
            return  completion(.success(data))
        }
        
        task.resume()
    }
}

// A concrete implementation of the client
class OWClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }
    
    func getWeather(from profile: Endpoint, completion: @escaping (Result<Data, APIError>) -> Void) {
        
        guard let request = profile.request else { return completion(.failure(.invalidRequest)) }
        
        fetch(with: request, completion: completion)
    }
    
}

