//
//  DetailNewsView.swift
//  NewsApp
//
//  Created by Finn Christoffer Kurniawan on 14/01/23.
//

import UIKit

class DetailNewsView: UIView {
    
    // MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()

    internal lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    internal lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    internal lazy var newsImageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configure() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(contentLabel)
        scrollView.addSubview(newsImageView)
        scrollView.contentSize = CGSize(width: frame.width, height: contentLabel.frame.maxY)
    }
    
    private func setupConstraints() {
        scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor,  bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0,paddingRight: 0)
        titleLabel.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingRight: 15)
        newsImageView.anchor(top: titleLabel.bottomAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingRight: 15, width: 350, height: 200)
        contentLabel.anchor(top: newsImageView.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
    }
}
