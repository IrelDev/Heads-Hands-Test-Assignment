//
//  NewsFeedCollectionViewCell.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 17.09.2021.
//

import UIKit

class NewsFeedCollectionViewCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupNSLayoutConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension NewsFeedCollectionViewCell {
    func setupViews() {
        addSubview(imageView)
    }
    func setupNSLayoutConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
