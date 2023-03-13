//
//  Article.swift
//  GoodNews
//
//  Created by mun on 2023/03/13.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]?
}

struct Article: Decodable {
    let title: String?
    let description: String?
}
 
