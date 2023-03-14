//
//  OrderViewModel.swift
//  HotCoffee
//
//  Created by mun on 2023/03/14.
//

import Foundation

class OrderListViewModel { //OrderTableViewController에 적용될 것
    var ordersViewModel: [OrderViewModel]
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
}

extension OrderListViewModel {
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
}

struct OrderViewModel {
    let order: Order
}

extension OrderViewModel {
    
    var name: String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
    
    init(_ order: Order) {
        self.order = order
    }
}
