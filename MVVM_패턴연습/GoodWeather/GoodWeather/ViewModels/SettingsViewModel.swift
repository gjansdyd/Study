//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by mun on 2023/03/15.
//

import Foundation

enum Unit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    var displayName: String {
        get {
            switch self {
            case .celsius:
                return "Celsius"
            case .fahrenheit:
                return "Fahrenheit"
            }
        }
    }
}

class SettingsViewModel {
    let units = Unit.allCases
    var selectedUnit: Unit {
        get {
            let userDefault = UserDefaults.standard
            guard let unitRawVal = userDefault.string(forKey: "unit"),
                  let unit = Unit(rawValue: unitRawVal)
            else { return .celsius }
            
            return unit
        }
        set {
            let userDefault = UserDefaults.standard
            userDefault.set(newValue.rawValue, forKey: "unit")
        }
    }
}
