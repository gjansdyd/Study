//
//  String+Extensions.swift
//  GoodWeather
//
//  Created by mun on 2023/03/15.
//

import Foundation

extension String {
    func escaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
