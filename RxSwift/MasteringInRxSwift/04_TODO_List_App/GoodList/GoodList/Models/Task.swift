//
//  Task.swift
//  GoodList
//
//  Created by mun on 2023/03/03.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}
struct Task {
    let title: String
    let priority: Priority
}
