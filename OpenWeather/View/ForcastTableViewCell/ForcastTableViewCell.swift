//
//  ForcastTableViewCell.swift
//  OpenWeather
//
//  Created by C.Green on 22/10/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ForcastTableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var weatherLabel: UILabel!
    
    @IBOutlet var temperatureLabel: UILabel!
    
    func configure(with weatherInformation: WeatherInformation, using dateFormatter: DateFormatter) {
        
        dateLabel.text = dateFormatter.string(from: weatherInformation.time)
        
        weatherLabel.text = weatherInformation.weather.map({ $0.desc.capitalized }).joined(separator: ", ")
        
        let temp = String(format: "%.1f", weatherInformation.main.temperature.celsius)
        temperatureLabel.text = "Temperature \(temp) C"
    }
    
}

extension ForcastTableViewCell: Dequeuable {}

extension Double {
    
    var kelvin: Double { return self }
    var celsius: Double { return self - 273.15 }
    var fahrenheit: Double { return (self.celsius * 1.8) + 32 }
}
