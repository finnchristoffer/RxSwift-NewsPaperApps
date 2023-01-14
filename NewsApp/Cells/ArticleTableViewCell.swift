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
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        return view
    }()
    
    internal lazy var publishedTimmeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = .gray
        return view
    }()
    
    internal lazy var thumbnailImage: UIImageView = {
        let image = UIImageView()
         image.contentMode = .scaleAspectFit
         return image
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 3
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
        addSubview(thumbnailImage)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(publishedTimmeLabel)
    }
    
    private func setupConstraints() {
        stackView.anchor(top: topAnchor, left: thumbnailImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 15, paddingBottom: 10, paddingRight: 15)
        thumbnailImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingLeft: 15, paddingBottom: 10, width: 120, height: 120)
    }
}
