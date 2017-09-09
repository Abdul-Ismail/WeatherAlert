//
//  WeatherDisplayViewController.swift
//  WeatherAlert
//
//  Created by Abdulaziz Ismail on 09/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

class WeatherDisplayViewController: UIViewController {

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    let forecastAPIKey = "bd99e86549d22a6aa4c23831987e22ea"
    let cordinate: (latitude: Double, longitude: Double) = (37.8267, -122.4233)
        
        

    override func viewDidLoad() {
        super.viewDidLoad()

        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(latitude: cordinate.latitude, longitude: cordinate.longitude) { (currentWeather) in
            if let currentWeather = currentWeather {
                DispatchQueue.main.async {
                    if let temperature = currentWeather.temperature {
                        print(currentWeather)
                        self.temperature.text = "\(temperature)"
                    }
                }
            }
        }
    }


}
