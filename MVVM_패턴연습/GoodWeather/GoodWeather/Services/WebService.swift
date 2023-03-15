//
//  WebService.swift
//  GoodWeather
//
//  Created by mun on 2023/03/15.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class WebService {
    func load<T>(resource: Resource<T>,
                 completion: @escaping (T?) -> ()) {
        URLSession.shared.dataTask(with: resource.url,
                                   completionHandler: { data, response, error in
            if let data = data {
                print(data)
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
            
        }).resume()
    }
}
