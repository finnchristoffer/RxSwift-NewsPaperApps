//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by Finn Christoffer Kurniawan on 13/01/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ArticleTableViewCell: UITableViewCell {
    
    static let identifier = "ArticleCell"
    
    //MARK: - Properties
    internal lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.numberOfLines = 0
        return view
    }()
    
    internal lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical

        view.spacing = 5
        return view
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    private func setupView() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 15, paddingBottom: 20, paddingRight: 15)
    }
}
