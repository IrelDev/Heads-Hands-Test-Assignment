//
//  NewsFeedSizeCalculator.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 17.09.2021.
//

import UIKit

struct NewsFeedSizeCalculator {
    func calculateEstimatedRowHeightDependingOnConstants(model: FeedItem?, viewWidth: CGFloat) -> CGFloat {
        let text = model?.text
        
        let headerTitleDateHeight = UIConstants.newsFeedHeadeHeight
        let titleDateHeaderSpacing = UIConstants.titleDateHeaderSpacing
        let headerSpacing = UIConstants.newsFeedElementSpacing
        
        let footerHeight = UIConstants.newsFeedButtonHeight
        let cellSpacing = UIConstants.newsFeedElementSpacing
        let insets = UIConstants.inset
        
        let attachmentSize = calculateAttachmentCollectionViewHeight(attachments: model?.attachments ?? [], viewWidth: viewWidth)
        let textHeight = calculatedHeight(for: text ?? "", width: viewWidth)
        
        let headerHeight = headerTitleDateHeight + textHeight + headerSpacing + titleDateHeaderSpacing
        let height = headerHeight + footerHeight + cellSpacing * 2 + insets * 2
        
        if let attachments = model?.attachments, !attachments.isEmpty {
            return CGFloat(height + cellSpacing) + attachmentSize
        } else {
            return CGFloat(height)
        }
    }
    
    func calculateAttachmentCollectionViewHeight(attachments: [Attachment], viewWidth: CGFloat) -> CGFloat {
        if attachments.isEmpty {
            return 0
        } else {
            var size: CGFloat = 0
            attachments.enumerated().forEach { element in
                if element.offset != 0 {
                    if element.offset % 2 == 0 {
                        size += UIConstants.attachmentSmallHeight
                    } else {
                        if element.offset == attachments.count - 1 {
                            var ratio: CGFloat = 1.0
                            if let photo = element.element.photo {
                                ratio = CGFloat(photo.height) / CGFloat(photo.width)
                            } else if let video = element.element.video {
                                ratio = CGFloat(video.imageHeight) / CGFloat(video.imageWidth)
                            }
                            
                            
                            size += viewWidth * ratio
                        }
                    }
                } else {
                    var ratio: CGFloat = 1.0
                    if let photo = element.element.photo {
                        ratio = CGFloat(photo.height) / CGFloat(photo.width)
                    } else if let video = element.element.video {
                        ratio = CGFloat(video.imageHeight) / CGFloat(video.imageWidth)
                    }
                    
                    
                    size += viewWidth * ratio
                }
            }
            return size
        }
    }
    
    func calculateAttachmentSize(attachments: [Attachment], row: Int, viewWidth: CGFloat) -> CGSize {
        var size: CGSize
        if row == 0 || row == attachments.count - 1 && row % 2 != 0 {
            var ratio: CGFloat = 1.0
            
            let attachment = attachments[row]
            
            if let photo = attachment.photo {
                ratio = CGFloat(photo.height) / CGFloat(photo.width)
            } else if let video = attachment.video {
                ratio = CGFloat(video.imageHeight) / CGFloat(video.imageWidth)
            }
            
            let height = viewWidth * CGFloat(ratio)
            size = CGSize(width: viewWidth, height: height)
        } else {
            size = CGSize(width: viewWidth / 2 - UIConstants.minimumInteritemSpacingForSectionAt, height: UIConstants.attachmentSmallHeight)
        }
        return size
    }
    
    func calculatedHeight(for text: String, width: CGFloat, font: UIFont = UIFont.systemFont(ofSize: 14)) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
}
