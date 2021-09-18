//
//  NewsFeedFooterView.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import UIKit

fileprivate let spacing: CGFloat = 4

fileprivate func makeStackView() -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    
    stackView.spacing = spacing
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.heightAnchor.constraint(equalToConstant: UIConstants.newsFeedButtonHeight).isActive = true
    
    return stackView
}
fileprivate func makeLabel() -> UILabel {
    let label = UILabel()
    
    label.font = UIFont.systemFont(ofSize: 13)
    label.textColor = UIColor(named: "SecondaryTextColor")
    label.textAlignment = .left
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.heightAnchor.constraint(equalToConstant: UIConstants.newsFeedButtonHeight).isActive = true
    
    return label
}
fileprivate func makeImageView(image: UIImage?) -> UIImageView {
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.widthAnchor.constraint(equalToConstant: UIConstants.newsFeedButtonHeight).isActive = true
    return imageView
}
class NewsFeedFooterView: UIView {
    lazy var containerStackView: UIStackView = {
        let containerStackView = UIStackView()
        containerStackView.axis = .horizontal
        
        containerStackView.alignment = .center
        containerStackView.distribution = .equalCentering
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        return containerStackView
    }()
    let buttonsContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        return stackView
    }()
    
    lazy var loveStackView: UIStackView = {
        makeStackView()
    }()
    lazy var loveImageView: UIImageView = {
        makeImageView(image: UIImage(named: "icLike"))
    }()
    lazy var loveLabel: UILabel = {
        makeLabel()
    }()
    
    lazy var commentsStackView: UIStackView = {
        makeStackView()
    }()
    lazy var commentsImageView: UIImageView = {
        makeImageView(image: UIImage(named: "icComment"))
    }()
    lazy var commentsLabel: UILabel = {
        makeLabel()
    }()
    
    lazy var shareStackView: UIStackView = {
        makeStackView()
    }()
    lazy var shareImageView: UIImageView = {
        makeImageView(image: UIImage(named: "icShare"))
    }()
    lazy var shareLabel: UILabel = {
        makeLabel()
    }()
    
    lazy var eyeStackView: UIStackView = {
        let stackView = makeStackView()
        stackView.alignment = .trailing
        return stackView
    }()
    lazy var eyeImageView: UIImageView = {
        makeImageView(image: UIImage(named: "icEye"))
    }()
    lazy var eyeLabel: UILabel = {
        makeLabel()
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
        eyeLabel.text = nil
        loveLabel.text = nil
        shareLabel.text = nil
        commentsLabel.text = nil
    }
}
extension NewsFeedFooterView {
    func setupViews() {
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(buttonsContainerStackView)
        
        buttonsContainerStackView.addArrangedSubview(loveStackView)
        loveStackView.addArrangedSubview(loveImageView)
        loveStackView.addArrangedSubview(loveLabel)
        
        buttonsContainerStackView.addArrangedSubview(commentsStackView)
        commentsStackView.addArrangedSubview(commentsImageView)
        commentsStackView.addArrangedSubview(commentsLabel)
        
        buttonsContainerStackView.addArrangedSubview(shareStackView)
        shareStackView.addArrangedSubview(shareImageView)
        shareStackView.addArrangedSubview(shareLabel)
        
        containerStackView.addArrangedSubview(eyeStackView)
        eyeStackView.addArrangedSubview(eyeImageView)
        eyeStackView.addArrangedSubview(eyeLabel)
    }
    func setupNSLayoutConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.inset),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.inset),
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            loveStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            eyeStackView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.3)
        ])
    }
}

