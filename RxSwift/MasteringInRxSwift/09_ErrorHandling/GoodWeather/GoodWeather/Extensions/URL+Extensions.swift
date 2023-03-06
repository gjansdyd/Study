//
//  URL+Extensions.swift
//  GoodWeather
//
//  Created by mun on 2023/03/04.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=f5a13152f438248fd8f95ec999c7ddb2")
    }
}
