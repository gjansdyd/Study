//
//  Article.swift
//  GoodNews
//
//  Created by mun on 2023/03/04.
//

import Foundation

struct ArticlesList: Codable {//for decoding
    let articles: [Article]
}
extension ArticlesList {
    static var all: Resource<ArticlesList> = {
       let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=a3aad58231a3463c86338cf7a5ffee24")!
        return Resource(url: url)
    }()
}
struct Article: Codable {//for decoding
    let title, description: String?
}
