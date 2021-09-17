//
//  NewsFeedHeaderView.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import UIKit

class NewsFeedHeaderView: UIView {
    var textViewHeightConstraint: NSLayoutConstraint!
    
    lazy var containerStackView: UIStackView = {
        let containerStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.spacing = 16
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        return containerStackView
    }()
    lazy var headerStackView: UIStackView = {
        let headerStackView = UIStackView()
        headerStackView.axis = .horizontal
        headerStackView.spacing = 12
        headerStackView.alignment = .center
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        return headerStackView
    }()
    lazy var titleDateStackView: UIStackView = {
        let titleDateStackView = UIStackView()
        titleDateStackView.axis = .vertical
        titleDateStackView.alignment = .leading
        titleDateStackView.spacing = 2
        
        return titleDateStackView
    }()
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        return titleLabel
    }()
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = UIColor(named: "SecondaryTextColor")
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        
        return dateLabel
    }()
    
    lazy var contentTextView: UITextView = {
        let contentTextView = UITextView()
        contentTextView.font = UIFont.systemFont(ofSize: 14)
        contentTextView.backgroundColor = .clear
        contentTextView.isEditable = false
        contentTextView.dataDetectorTypes = [.all]
        contentTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        contentTextView.isScrollEnabled = false
        return contentTextView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setupNSLayoutConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func reset() {
        imageView.image = nil
        dateLabel.text = nil
        titleLabel.text = nil
        contentTextView.text = nil
        
        textViewHeightConstraint.constant = 0
    }
}
extension NewsFeedHeaderView {
    func setupViews() {
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(headerStackView)
        headerStackView.addArrangedSubview(imageView)
        headerStackView.addArrangedSubview(titleDateStackView)
        
        titleDateStackView.addArrangedSubview(titleLabel)
        titleDateStackView.addArrangedSubview(dateLabel)
        
        containerStackView.addArrangedSubview(contentTextView)
    }
    func setupNSLayoutConstraints() {
        textViewHeightConstraint = contentTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                        
            textViewHeightConstraint,
            imageView.widthAnchor.constraint(equalToConstant: 44),
            headerStackView.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
