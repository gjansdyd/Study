//
//  WebService.swift
//  GoodNews
//
//  Created by mun on 2023/03/13.
//

import Foundation

class WebService {
    func getArticles(url: URL, completion: @escaping ([Article]?) -> ()) {
        URLSession.shared.dataTask(with: url,
                                   completionHandler: { data, response, error in
            guard let data = data,
                  let articleList = try? JSONDecoder().decode(ArticleList.self, from: data).articles
            else {
                print(error.debugDescription)
                completion(nil)
                return
            }
            
            completion(articleList)
            
        }).resume()
    }
}
