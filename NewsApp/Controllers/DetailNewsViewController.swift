//
//  DetailNewsViewController.swift
//  NewsApp
//
//  Created by Finn Christoffer Kurniawan on 14/01/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DetailNewsViewController: UIViewController {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    private var articleListVM: DetailArticleListViewModel!
    var selectedArticle: DetailArticleViewModel?
    private var detailNewsView = DetailNewsView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        view.addSubview(detailNewsView)
        detailNewsView.frame = view.bounds
        populateData()
    }
    
    // MARK: - Helpers
    func populateData() {
            if let article = selectedArticle {
                article.title.asDriver(onErrorJustReturn: "").drive(detailNewsView.titleLabel.rx.text).disposed(by: disposeBag)
                article.content.asDriver(onErrorJustReturn: "").drive(detailNewsView.contentLabel.rx.text).disposed(by: disposeBag)
                article.image.asDriver(onErrorJustReturn: "").drive(onNext: { imageUrl in
                    if let url = URL(string: imageUrl) {
                        URLSession.shared.dataTask(with: url) { data, _, _ in
                            if let data = data {
                                DispatchQueue.main.async {
                                    self.detailNewsView.newsImageView.image = UIImage(data: data)
                                }
                            }
                        }.resume()
                    }
                }).disposed(by: disposeBag)
            }
        }
}
