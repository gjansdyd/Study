//
//  LoginViewModel.swift
//  BindingMVVM
//
//  Created by mun on 2023/03/16.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    func bind(callBack: @escaping (T) -> Void) {
        self.listener = callBack
    }
    init(value: T) {
        self.value = value
    }
    
}

struct LoginViewModel {
    var userName = Dynamic(value: "")
    var password = Dynamic(value: "")
}
