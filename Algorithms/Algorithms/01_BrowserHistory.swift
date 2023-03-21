//
//  BrowserHistory.swift
//  Algorithms
//
//  Created by mun on 2023/03/21.
//

//Q: https://leetcode.com/problems/design-browser-history/
//A: 
import Foundation

fileprivate class Node<T> {
    var data: T?
    var prev: Node<T>?
    var next: Node<T>?
    init(data: T? = nil,
         prev: Node<T>? = nil,
         next: Node<T>? = nil) {
        self.data = data
        self.prev = prev
        self.next = next
    }
}

fileprivate class LinkedList {
    var head: Node<String>
    init(initUrl: String) {
        self.head = Node(data: "initUrl")
    }
    internal func append(url data: String) {
        let newNode = Node(data: data)
        
        var tmpNode: Node<String>? = self.head
        while tmpNode?.next != nil {
            tmpNode = tmpNode?.next
        }
        tmpNode?.next = newNode
    }
    
    internal func delete(at idx: Int) -> Bool {
        var rtnVal = true
        var tmp: Node<String>? = self.head
        
        (0 ..< idx-1).forEach { _ in
            tmp = tmp?.next
            if tmp == nil { rtnVal = false }
        }
        tmp?.next = tmp?.next?.next
        return rtnVal
    }
    
    internal func printAll() {
        var tmpNode: Node<String>? = self.head
        while tmpNode != nil {
            print(tmpNode?.data)
            tmpNode = tmpNode?.next
        }
    }
}

//========
fileprivate class BrowserHistory {
    var head: Node<String>
    var crnt: Node<String>
    var tail: Node<String>
    init(_ url: String) {
        let initNode = Node(data: url)
        self.head = initNode
        self.crnt = initNode
        self.tail = initNode
    }
    internal func visit(_ url: String) {
        let newNode = Node(data: url)
        newNode.prev = tail
        tail.next = newNode
        self.tail = newNode
        self.crnt = newNode
    }
    internal func back(_ count: Int) -> String? {
        var crntCount = 0
        while crntCount < count {
            guard let prev = self.crnt.prev else { break }
            self.crnt = prev
            crntCount += 1
        }
        
        return self.crnt.data
    }
    
    internal func forward(_ count: Int) -> String? {
        var crntCount = 0
        while crntCount < count {
            guard let next = self.crnt.next else { return nil }
            self.crnt = next
            crntCount += 1
        }
        
        return self.crnt.data
    }
    
    internal func printAll() {
        var tmpNode: Node<String>? = self.head
        while tmpNode != nil {
            tmpNode = tmpNode?.next
        }
    }
}

func browserHistory() {
    let browserHistory = BrowserHistory("leetcode.com");
    print(browserHistory.visit("google.com"))
    print(browserHistory.visit("facebook.com"))
    print(browserHistory.visit("youtube.com"))
    print(browserHistory.back(1))
    print(browserHistory.back(1))
    print(browserHistory.forward(1))
    print(browserHistory.visit("linkedin.com"))
    print(browserHistory.forward(2))
    print(browserHistory.back(2))
    print(browserHistory.back(7))
}

