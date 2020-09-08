//
//  FiveDayForcastModel.swift
//  OpenWeather
//
//  Created by C.Green on 22/10/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation

typealias ClientReposnse = (Result<Data, APIError>) -> Void
typealias UpdateResponse = (Bool) -> Swift.Void

class FiveDayForcastModel {
    
    private let client: OWClient
    
    private var forcast = [WeatherInformation]()
    
    init(_ client: OWClient) {
        self.client = client
    }
    
    func updateForcast(for city: String = "London", in countryCode: String, completion: @escaping UpdateResponse) {
        
        let forcast = OpenWeatherRequest.fiveDayForcast(city: city, countryCode: countryCode)
        
        client.getWeather(from: forcast) { result in
            
            switch result {
            case .success(let data):
                
                do {
                    let data = try DataParser.parse(data, type: APIResponse.self)
                    self.forcast = data.forcast
                    completion(true)
                } catch {
                    print(error)
                    completion(false)
                }
                
            case .failure(let error):
                print(error)
                completion(false)
            }
            
        }
    }
    
    // MARK: - TableView Code
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return forcast.count
    }
    
    func item(at indexPath: IndexPath) -> WeatherInformation {
        return forcast[indexPath.row]
    }
    
}
