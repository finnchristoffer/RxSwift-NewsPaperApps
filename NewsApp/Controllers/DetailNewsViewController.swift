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
    
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()

    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        configure()
        setupConstraints()
        populateData()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(contentLabel)
        scrollView.addSubview(newsImageView)
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentLabel.frame.maxY)
    }
    
    private func setupConstraints() {
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,  bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0,paddingRight: 0)
        titleLabel.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingRight: 15)
        newsImageView.anchor(top: titleLabel.bottomAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingRight: 15, width: 350, height: 200)
        
        contentLabel.anchor(top: newsImageView.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
    }

    func populateData() {
            if let article = selectedArticle {
                article.title.asDriver(onErrorJustReturn: "").drive(titleLabel.rx.text).disposed(by: disposeBag)
                article.content.asDriver(onErrorJustReturn: "").drive(contentLabel.rx.text).disposed(by: disposeBag)
                article.image.asDriver(onErrorJustReturn: "").drive(onNext: { imageUrl in
                    if let url = URL(string: imageUrl) {
                        URLSession.shared.dataTask(with: url) { data, _, _ in
                            if let data = data {
                                DispatchQueue.main.async {
                                    self.newsImageView.image = UIImage(data: data)
                                }
                            }
                        }.resume()
                    }
                }).disposed(by: disposeBag)
            }
        }
}
