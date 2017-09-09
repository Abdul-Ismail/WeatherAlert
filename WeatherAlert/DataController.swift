//
//  DataController.swift
//  WeatherAlert
//
//  Created by Abdulaziz Ismail on 08/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import Foundation

class DataController {
    
    //lazy - Don't initialize these properties until I use it for the first time
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)//provides an API for downloading content
    
    let url: URL
    
    init(requestedURL: URL){
        self.url = requestedURL
    }
    
    //allias will be like an altenrative name
    typealias JSONDictonaryHandler = (([String : Any]?) -> Void )
    
    func downloadJSONFromURL(_ completion: @escaping JSONDictonaryHandler)
    {
        let request = URLRequest(url: self.url)
        //downloading data
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil{
                
                if let httpResponse = response as? HTTPURLResponse {
                    //httpresponse is a response on getting the data
                    if httpResponse.statusCode == 200
                    {                        //data obtained
                        if let data = data
                          {
                            //pass data into json dictionary 
                            do
                            {
                                let JsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                                
                                completion(JsonDictionary as? [String : Any])
                                
                            } catch let error as NSError {
                                 print("Error at mutableContainers\(error.localizedDescription)")
                          }
                    }else {
                            print("http response code: \(httpResponse.statusCode)")
                        }
                    }
                }
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        dataTask.resume()
    }
    
}
