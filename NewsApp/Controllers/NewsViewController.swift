//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Finn Christoffer Kurniawan on 13/01/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

private let reuseIdentifier = "ArticleCell"

class NewsViewController: UIViewController {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    private var articleListVM: ArticleListViewModel!
    private var newsView: NewsView!
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        newsView = NewsView(frame: view.frame)
        view = newsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        newsView.setupConstraints()
        configure()
        populateNews()
    }
    
    // MARK: - Helpers
    
    func configure() {
        view.backgroundColor = .white
        navigationItem.title = "News App"
        
        newsView.tableView.delegate = self
        newsView.tableView.dataSource = self
        newsView.tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        newsView.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func populateNews() {
        
        let resource = Resource<ArticleResponse>(url: URL.urlForNews()!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { articleResponse in
                let articles = articleResponse.articles
                self.articleListVM = ArticleListViewModel(articles)
                DispatchQueue.main.async {
                    self.newsView.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }

}

// MARK: - UITableViewSource & UITableViewDelegate
extension NewsViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0: self.articleListVM.articlesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell is not found")
        }
        
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        articleVM.published.asDriver(onErrorJustReturn: "")
            .drive(cell.publishedTimmeLabel.rx.text)
            .disposed(by: disposeBag)
        articleVM.image.asDriver(onErrorJustReturn: "").drive(onNext: { imageUrl in
            if let url = URL(string: imageUrl) {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data {
                        DispatchQueue.main.async {
                            cell.thumbnailImage.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        }).disposed(by: disposeBag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = DetailArticleViewModel(self.articleListVM.articleAt(indexPath.row).article)
        let detailVC = DetailNewsViewController()
        detailVC.selectedArticle = selectedArticle
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

