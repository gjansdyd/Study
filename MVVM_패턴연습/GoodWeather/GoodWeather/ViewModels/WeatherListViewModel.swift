//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by mun on 2023/03/15.
//

import Foundation

class WeatherListViewModel {
    private var weatherViewModels = [WeatherViewModel]()
    func addWeahterViewModel(_ vm: WeatherViewModel) {
        weatherViewModels.append(vm)
    }
    func numberOfRows(_ section: Int) -> Int {
        return weatherViewModels.count
    }
    func modelAt(_ index: Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }
    func updateUnit(to unit: Unit) {
        switch unit {
        case .celsius:
            toCelcius()
        case .fahrenheit:
            toFahrenheit()
        }
    }
    private func toCelcius() {
        weatherViewModels = weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.temperature = (weatherModel.temperature - 32) * 5 / 9
            return weatherModel
        }
    }
    private func toFahrenheit() {
        weatherViewModels = weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.temperature = weatherModel.temperature*9/5+32
            return weatherModel
        }
    }
}

class WeatherViewModel {
    var weather: WeatherResponse
    
    init(weather: WeatherResponse) {
        self.weather = weather
    }
    
    var city: String {
        return weather.name
    }
    
    var temperature: Double {
        get {
            return weather.main.temp
        }
        set {
            weather.main.temp = newValue
        }
    }
}
