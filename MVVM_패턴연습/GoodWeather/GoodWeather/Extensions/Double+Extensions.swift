//
//  Double+Extensions.swift
//  GoodWeather
//
//  Created by mun on 2023/03/15.
//

import Foundation

extension Double {
    func formatAsDegree() -> String{
        return String(format: "%.0f", self)
    }
}
