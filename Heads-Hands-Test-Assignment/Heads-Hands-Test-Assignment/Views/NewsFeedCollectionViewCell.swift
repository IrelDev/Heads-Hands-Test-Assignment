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
    lazy var videoButton: UIButton = {
        let videoButton = UIButton(type: .custom)
        videoButton.setImage(UIImage(named: "icPlay"), for: .normal)
        
        videoButton.isHidden = true
        videoButton.translatesAutoresizingMaskIntoConstraints = false
        return videoButton
    }()
    lazy var videoDurationLabel: UILabel = {
       let videoDurationLabel = UILabel()
        videoDurationLabel.font = UIFont.systemFont(ofSize: 13)
        videoDurationLabel.isHidden = true
        
        videoDurationLabel.textColor = .white
        videoDurationLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
        videoDurationLabel.layer.cornerRadius = UIConstants.newsFeedButtonHeight / 4
        videoDurationLabel.textAlignment = .center
        
        videoDurationLabel.clipsToBounds = true
        videoDurationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return videoDurationLabel
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupNSLayoutConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupAttachmentAsVideo(video: Video) {
        videoButton.isHidden = false
        videoDurationLabel.isHidden = false
        
        let videoSeconds = video.duration
        let (hours, minutes, seconds) = (videoSeconds / 3600, (videoSeconds % 3600) / 60, (videoSeconds % 3600) % 60)

        videoDurationLabel.text = "\(hours):\(minutes):\(seconds)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        videoButton.isHidden = true
        videoDurationLabel.isHidden = true
    }
}
extension NewsFeedCollectionViewCell {
    func setupViews() {
        addSubview(imageView)
        addSubview(videoButton)
        addSubview(videoDurationLabel)
    }
    func setupNSLayoutConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            videoButton.heightAnchor.constraint(equalToConstant: UIConstants.buttonHeight * 2),
            videoButton.widthAnchor.constraint(equalToConstant: UIConstants.buttonHeight * 2),
            
            videoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            videoButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            videoDurationLabel.heightAnchor.constraint(equalToConstant: UIConstants.newsFeedButtonHeight),
            videoDurationLabel.widthAnchor.constraint(equalToConstant: UIConstants.newsFeedButtonHeight * 2.3),
            
            videoDurationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.inset),
            videoDurationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.inset)
        ])
    }
}
