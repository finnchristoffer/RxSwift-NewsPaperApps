//
//  DetailArticleViewModel.swift
//  NewsApp
//
//  Created by Finn Christoffer Kurniawan on 14/01/23.
//

import Foundation
import RxSwift
import RxCocoa

struct DetailArticleListViewModel {
    let articlesVM: [DetailArticleViewModel]
    
    init(_ articles: [Article]) {
        self.articlesVM = articles.compactMap(DetailArticleViewModel.init)
    }
}

extension DetailArticleListViewModel {
    
    func articleAt(_ index: Int) -> DetailArticleViewModel {
        return self.articlesVM[index]
    }
}

struct DetailArticleViewModel {
    
    let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
}

extension DetailArticleViewModel {
    var title: Observable<String> {
        return Observable<String>.just(article.title)
    }
    
    var content: Observable<String> {
        return Observable<String>.just(article.content ?? "")
    }
    
    var image: Observable<String> {
        return Observable<String>.just(article.urlToImage ?? "")
    }
}
