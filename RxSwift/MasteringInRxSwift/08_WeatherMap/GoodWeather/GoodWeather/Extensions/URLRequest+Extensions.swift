//
//  URLRequest+Extensions.swift
//  GoodWeather
//
//  Created by mun on 2023/03/04.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct Resouce<T> {
    let url: URL
}

extension URLRequest {
    static func load<T: Decodable>(resource: Resouce<T>) -> Observable<T> {
        return Observable.from([resource.url])
            .flatMap ({ url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }).map({ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }).asObservable()
    }
}
