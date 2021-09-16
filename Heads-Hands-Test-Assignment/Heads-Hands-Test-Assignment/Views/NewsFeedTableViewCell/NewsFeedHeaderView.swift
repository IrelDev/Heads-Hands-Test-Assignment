//
//  NewsFeedHeaderView.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import UIKit

class NewsFeedHeaderView: UIView {
    lazy var containerStackView: UIStackView = {
       let containerStackView = UIStackView()
        containerStackView.axis = .vertical
        
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
        dateLabel.textColor = .gray
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        
        return dateLabel
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setupNSLayoutConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    }
    func setupNSLayoutConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: 44),
            headerStackView.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
