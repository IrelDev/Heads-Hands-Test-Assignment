//
//  NewsFeedTableViewCell.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    var headerView = NewsFeedHeaderView()
    var footerView = NewsFeedFooterView()
    
    var attachments: [Attachment]?
    
    var contentCollectionViewConstraint: NSLayoutConstraint!
    
    var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let contentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        contentCollectionView.backgroundColor = .clear
        contentCollectionView.isScrollEnabled = false
        
        contentCollectionView.showsHorizontalScrollIndicator = false
        contentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return contentCollectionView
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupNSLayoutConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        headerView.reset()
        attachments = nil
    }
}
extension NewsFeedTableViewCell {
    func setupViews() {
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        
        contentView.autoresizingMask = [.flexibleHeight]
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(contentCollectionView)
        stackView.addArrangedSubview(footerView)
        
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        contentCollectionView.register(NewsFeedCollectionViewCell.self, forCellWithReuseIdentifier: "attachmentCell")
    }
    func setupNSLayoutConstraints() {
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 0)
        bottomConstraint.priority = UILayoutPriority(999)
        
        contentCollectionViewConstraint = contentCollectionView.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0),
            
            bottomConstraint,
            contentCollectionViewConstraint
        ])
    }
}
extension NewsFeedTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let attachments = attachments else { return CGSize.zero }
        var sizes = CGSize()
        
        let width = bounds.width
        
        if indexPath.row == 0 || indexPath.row == attachments.count - 1 && indexPath.row % 2 != 0 {
            var ratio: CGFloat = 1.0
            
            let attachment = attachments[indexPath.row]
            
            if let photo = attachment.photo {
                ratio = CGFloat(photo.height) / CGFloat(photo.width)
            } else if let video = attachment.video {
                ratio = CGFloat(video.imageHeight) / CGFloat(video.imageWidth)
            }
            
            let height = width * CGFloat(ratio)
            sizes = CGSize(width: width, height: height)
        } else {
            sizes = CGSize(width: bounds.width / 2 - 2, height: 160)
        }
        return sizes
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
}
extension NewsFeedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        attachments?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attachmentCell", for: indexPath) as! NewsFeedCollectionViewCell
        guard let model = attachments?[indexPath.row] else { return UICollectionViewCell() }
        
        if let photo = model.photo {
            if let url = URL(string: photo.url) {
                cell.imageView.kf.setImage(with: url)
            }
        } else if let video = model.video {
            if let url = URL(string: video.imageUrl) {
                cell.imageView.kf.setImage(with: url)
            }
        }
        return cell
    }
}
