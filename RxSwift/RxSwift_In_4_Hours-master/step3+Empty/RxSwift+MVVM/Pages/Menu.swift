//
//  Menu.swift
//  RxSwift+MVVM
//
//  Created by mun on 2023/03/07.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import Foundation

//Model : View를 위한 모델 즉 ViewModel

struct Menu {
    var id: Int
    var name: String
    var price: Int
    var count: Int
}
extension Menu {
    static func fromMenuItems(id: Int, item: MenuItem) -> Menu {
        return Menu(id: id, name: item.name,
                    price: item.price,
                    count: 0)
    }
}
