//
//  WeatherResponse.swift
//  GoodWeather
//
//  Created by mun on 2023/03/15.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    var main: Weather
}

struct Weather: Decodable {
    var temp: Double
    let humidity: Double
}
