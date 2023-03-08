//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by mun on 2023/03/07.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MenuListViewModel {
    private let disposeBag = DisposeBag()
    init() {
       _ = APIService.fetchAllMenusRx()
            .map { data in
                struct Response: Decodable {
                    let menus: [MenuItem]
                }
                
                let response = try! JSONDecoder().decode(Response.self, from: data)
                return response.menus
                }
            .map { menuItems in
                menuItems.enumerated().map { idx, item in
                    Menu.fromMenuItems(id: idx, item: item)
                }
            }.take(1)
            .bind(to: menuObservable)
    }
    lazy var menuObservable = BehaviorSubject<[Menu]>(value: []) //Menu array를 받는 Subject
    lazy var itemsCount: Observable<Int> = menuObservable.map { menus in
        menus.map { $0.count }.reduce(0, +)
    }
//    var totalPrice: Int = 10_000
    lazy var totalPrice: Observable<Int> = menuObservable.map({ menus in
        menus.map { $0.price * $0.count }.reduce(0, +)
    })
    
    func clearAllItemSelections() {
        menuObservable.map( { menus in
            return menus.map { m in
                Menu(id: m.id,
                     name: m.name,
                     price: m.price,
                     count: 0)
            }
        })
        .take(1)    // 한 번 수행하고 종료되는 Observable
        .subscribe(onNext: {
            self.menuObservable.onNext($0)
        }).disposed(by: disposeBag)
    }
    
    func onOrder() {
        menuObservable.onNext([
            Menu(id: 0, name: "changed", price: 100, count: 2),
            Menu(id: 1, name: "changed", price: 100, count: 2),
            Menu(id: 2, name: "changed", price: 100, count: 2)
        ])
    }
    
    func changeCount(_ item: Menu, _ increase: Int) {
        menuObservable.map( { menus in
            return menus.map { m in
                print("munyong > m: \(m.name) / \(m.count)")
                if m.id == item.id {
                    return  Menu(id: m.id,
                                 name: m.name,
                                 price: m.price,
                                 count: m.count+increase)
                } else {
                    return Menu(id: m.id,
                                name: m.name,
                                price: m.price,
                                count: m.count)
                }
            }
        })
        .take(1)    // 한 번 수행하고 종료되는 Observable
        .subscribe(onNext: {
            self.menuObservable.onNext($0)
        }).disposed(by: disposeBag)
    }
    // Subject
    // Observable처럼 subscribe하여 값을 받아먹을 수도 있지만,
    // 외부의 값을 통제할 수도 있음.
}
