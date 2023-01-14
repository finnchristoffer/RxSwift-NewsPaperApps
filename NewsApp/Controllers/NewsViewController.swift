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
    
    lazy var tableView: UITableView = {
       let view = UITableView()
        
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        configure()
        setupConstraints()
        populateNews()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//    }
    
    // MARK: - Helpers
    
    func configure() {
        view.backgroundColor = .white
        navigationItem.title = "News App"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension

        
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
    private func populateNews() {
        
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=id&apiKey=003f9cf2364c4f338df38fe6400114e7")!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { articleResponse in
                let articles = articleResponse.articles
                self.articleListVM = ArticleListViewModel(articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }

}

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
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("1")
        let selectedArticle = self.articleListVM.articleAt(indexPath.row)
        let detailVC = DetailNewsViewController()
        detailVC.selectedArticle = selectedArticle
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
