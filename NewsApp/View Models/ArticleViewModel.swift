//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Finn Christoffer Kurniawan on 13/01/23.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
    let articlesVM: [ArticleViewModel]
    
    init(_ articles: [Article]) {
        self.articlesVM = articles.compactMap(ArticleViewModel.init)
    }
}

extension ArticleListViewModel {
    
    func articleAt(_ index: Int) -> ArticleViewModel {
        return self.articlesVM[index]
    }
}

struct ArticleViewModel {
    
    let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: Observable<String> {
        return Observable<String>.just(article.title)
    }

    var published: Observable<String> {
        return Observable<String>.just(article.publishedAt ?? "")
    }
    
    var image: Observable<String> {
        return Observable<String>.just(article.urlToImage ?? "")
    }
}
