//
//  WebService.swift
//  HotCoffee
//
//  Created by mun on 2023/03/13.
//

import Foundation

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
}
extension Resource {
    init(url: URL) {
        self.url = url
    }
}

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

class WebService {
    func load<T>(resource: Resource<T>,
                 completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request,
                                   completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError)); return
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.decodingError)); return
            }
            DispatchQueue.main.async {
                completion(.success(result))
            }
        }).resume()
    }
}
