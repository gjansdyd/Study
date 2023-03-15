//
//  Constants.swift
//  GoodWeather
//
//  Created by mun on 2023/03/15.
//

import Foundation

struct Constants {
    struct Urls {
        static func urlForWeatherByCity(city: String) -> URL? {
            guard let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=f5a13152f438248fd8f95ec999c7ddb2&units=\(SettingsViewModel().selectedUnit.rawValue)")
            else { return nil }
            
            return weatherURL
        }
    }
}
