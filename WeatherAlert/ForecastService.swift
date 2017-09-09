//
//  ForecastService.swift
//  WeatherAlert
//
//  Created by Abdulaziz Ismail on 09/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import Foundation

class ForecastService
{
    let forecastAPIKey: String
    let forecasBaseURL: URL?
    //forecastBaseURl/forecastAPIKey/latitude,longitude
    
    //init(APIkey)
    
    init(APIKey: String)
    {
        self.forecastAPIKey = APIKey
        self.forecasBaseURL = URL(string: "https://api.darksky.net/forecast/\(APIKey)")
    }
    
    func getForecast(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?) -> Void)
    {
        if let forecastURL = URL(string: "\(forecasBaseURL!)/\(latitude),\(longitude)")
        {
            let dataController = DataController(requestedURL: forecastURL)
            dataController.downloadJSONFromURL({ (jsonDictionary) in
                if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String : Any] {
                    let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                    completion(currentWeather)
                } else {
                    completion(nil)
                }
            })
        }
    }

}
