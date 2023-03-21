//
//  02_DailyTemperatures.swift
//  Algorithms
//
//  Created by mun on 2023/03/21.
//

//Q: https://leetcode.com/problems/daily-temperatures/
//A:
import Foundation

fileprivate class Node<T> {
    var data: T?
    var prev: Node<T>?
    var next: Node<T>?
    init(_ data: T? = nil, prev: Node<T>? = nil, tail: Node<T>? = nil) {
        self.data = data
        self.prev = prev
        self.next = tail
    }
}

fileprivate class DailyTemperatures {
    struct Temperature {
        var idx: Int = 0
        var temp: Int = 0
        var distance: Int = 0
    }
    
    var head: Node<Temperature>!
    var tail: Node<Temperature>!
    var count: Int = 0
    
    
    func solutions(_ temperatures: [Int]) -> [Int] {
        func addNode(idx: Int, t: Int) {
            let newNode = Node(Temperature(idx: idx, temp: t))
            if head == nil {
                head = newNode
                tail = newNode
            } else {
                newNode.prev = tail
                tail.next = newNode
                self.tail = newNode
            }
            count+=1
        }
        
        
        var tempertureObjArr = Array(repeating: Temperature(),
                                     count: temperatures.count)
        temperatures.enumerated().forEach { idx, temperature in //O(n)
            tempertureObjArr[idx].idx = idx
            tempertureObjArr[idx].temp = temperature
            
            guard let tail = tail,
                  tail.data?.temp ?? 0 < temperature else {
                addNode(idx: idx, t: temperature)
                return
            }
            
            let maxCount = count
            for _ in (0 ..< maxCount) {
                guard let tail = self.tail,
                      (self.tail.data?.temp ?? 0) < temperature else {
                    break
                }
                if let prevTail = self.tail.prev {
                    self.tail.prev?.next = nil
                    self.tail.prev = nil
                    self.tail = prevTail
                } else {
                    self.tail = self.head
                    self.head = nil
                }
                
                if let tObjArrIdx = tail.data?.idx {
                    tempertureObjArr[tObjArrIdx].distance = idx - tObjArrIdx
                }

                self.count -= 1
            }
            addNode(idx: idx, t: temperature)
        }
        
        return tempertureObjArr.map { $0.distance }
    }
}

func dailyTemperature() {
    print(DailyTemperatures().solutions([73,74,75,71,69,72,76,73]))
    print(DailyTemperatures().solutions([30, 40, 50, 60]))
    print(DailyTemperatures().solutions([30, 60, 90]))
}
