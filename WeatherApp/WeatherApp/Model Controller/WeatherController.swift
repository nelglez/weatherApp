//
//  WeatherController.swift
//  WeatherApp
//
//  Created by Nelson Gonzalez on 4/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class WeatherController {
    
  private let baseURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast")!
    private let apiKey = "5fb90a32c56d0428549831fd6dc0dd18"
    
    
    func getWeatherWith(cityName: String, completion: @escaping([Forecast]?, Error?)-> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        let cityQueryItem = URLQueryItem(name: "q", value: cityName)
        
        let imperialQueryItem = URLQueryItem(name: "units", value: "imperial")
        
        let cntQueryItem = URLQueryItem(name: "cnt", value: "7")
        
        let apiKeyQueryItem = URLQueryItem(name: "appid", value: apiKey)
        
        urlComponents.queryItems = [cityQueryItem, imperialQueryItem, cntQueryItem, apiKeyQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing search URL for \(cityName)")
            completion(nil, NSError())
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data. No data returned")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                
                let result = try jsonDecoder.decode(Forecast.self
                    , from: data)
                
                completion([result], nil)
                
            } catch {
                NSLog("Unable to decode data into forecasts \(error)")
                completion(nil, error)
                return
            }
            
        }.resume()
        
        
    }
}

//Sample url structure
//https://api.openweathermap.org/data/2.5/forecast?q=miami,us&cnt=7&appid=5fb90a32c56d0428549831fd6dc0dd18
