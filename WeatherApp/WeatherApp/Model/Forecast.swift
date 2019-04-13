//
//  Weather.swift
//  WeatherApp
//
//  Created by Nelson Gonzalez on 4/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    let list: [List]
    let city: City
}
struct City: Codable {
    let name: String
}

struct List: Codable {
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let icon: String
}
