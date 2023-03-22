//
//  03_HashTable_01.swift
//  Algorithms
//
//  Created by mun on 2023/03/22.
//

// ArrayList -> open addressing
// key-value쌍의 데이터를 입력받음
// key값을 hash function에 넣어 index를 만듦
// 저장/ 삭제/ 검색의 시간복잡도는 모두 O(1)
// 충돌이 나면 옆으로 한 칸(여기서 1은 언어별 결정된 것을 따름) 이동
//cf. Direct Address? key값이 index임.

// dictionary 자료구조에서 정말 많이 쓰임
// 메모리 사용을 높이면 시간복잡도가 낮아진다

//MARK:
//Q.https://leetcode.com/problems/two-sum/
//A.
import Foundation

func twoSum(_ nums: [Int], target: Int) -> Bool {
    var dict = [Int: Int]()
    for num in nums {
        if let value = dict[target-num], target == num+value {
            return true
        }
        dict[num] = num
    }
    
    return false
}
