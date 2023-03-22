//
//  02_DailyTemperatures2.swift
//  Algorithms
//
//  Created by mun on 2023/03/22.
//
//Q: https://leetcode.com/problems/daily-temperatures/
//A:
import Foundation

func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
    var ans = Array(repeating: 0, count: temperatures.count)
    var stack = [(curDay: Int, curTemp: Int)]()
    for (curDay, temp) in temperatures.enumerated() {
        while let stackVal = stack.last, stackVal.curTemp < temp {
            if let last = stack.popLast() {
                ans[last.curDay] = curDay - last.curDay
            }
        }
        stack.append((curDay, temp))
    }
    return ans
}
