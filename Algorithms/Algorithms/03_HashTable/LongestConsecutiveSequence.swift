//
//  LongestConsecutiveSequence.swift
//  Algorithms
//
//  Created by mun on 2023/03/22.
//

//Q.https://leetcode.com/problems/longest-consecutive-sequence/
//A.
import Foundation

// 정렬되어 있지 않은 정수형 배열 nums가 주어졌을 때
// nums원소를 가지고 만들 수 있는 가장 긴 연속된 수의 갯수는 몇 개일까?
// 제한조건 때문에 n * n은 불가능.
func longestConsecutiveSequence(_ nums: [Int]) -> Int {
    var dict = [Int: Int]()
    var maxCount = 0
    nums.forEach {
        dict[$0] = $0
    }
    nums.forEach { num in
        //처음시작 찾기
        guard nil == dict[num-1] else {
            return
        }
        var target = num
        var count = 0
        while nil != dict[target] {
            target += 1
            count += 1
        }
        maxCount = max(maxCount, count)
//        if let _ = dict[num-1] {
//            tmpCount += 1
//        }
//        if let _ = dict[num+1] {
//            tmpCount += 1
//        }
//
//        if tmpCount > maxCount {
//            maxCount = tmpCount+1 // 본인 포함
//        }
//        dict[num] = num
    }
    
    return maxCount
}
