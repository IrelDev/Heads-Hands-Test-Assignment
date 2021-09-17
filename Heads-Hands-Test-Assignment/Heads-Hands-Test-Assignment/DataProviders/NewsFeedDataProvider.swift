//
//  NewsFeedDataProvider.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 17.09.2021.
//

import UIKit

struct NewsFeedDataProvider {
    let dataSource: FeedResponse
    let newsFeedSizeCalculator: NewsFeedSizeCalculator
    let viewWidth: CGFloat
    
    init(dataSource: FeedResponse, newsFeedSizeCalculator: NewsFeedSizeCalculator, viewWidth: CGFloat) {
        self.dataSource = dataSource
        self.newsFeedSizeCalculator = newsFeedSizeCalculator
        self.viewWidth = viewWidth
    }
    
    public func provideData(cell: NewsFeedTableViewCell, row: Int) {
        let model = dataSource.items[row]
        let profiles = dataSource.profiles
        let groups = dataSource.groups
        
        let headerRepresentation = searchProfile(for: model.sourceId, profiles: profiles, groups: groups)
        
        guard let url = URL(string: headerRepresentation.image) else {
            return
        }
        
        let date = Date(timeIntervalSince1970: model.date)
        let dateTitle = getDateFromTimeInterval(date: date)
        
        if let attachments = model.attachments, !attachments.isEmpty {
            cell.attachments = attachments
            let attachmentSize = newsFeedSizeCalculator.calculateAttachmentCollectionViewHeight(attachments: attachments, viewWidth: viewWidth)
            
            cell.contentCollectionViewConstraint.constant = attachmentSize
            cell.contentCollectionView.layoutIfNeeded()
            cell.contentCollectionView.reloadData()
            cell.contentCollectionView.isHidden = false
        } else {
            cell.contentCollectionView.isHidden = true
        }
        
        cell.headerView.dateLabel.text = dateTitle
        cell.headerView.titleLabel.text = headerRepresentation.title
        cell.headerView.imageView.kf.setImage(with: url)
        
        if model.text == nil || model.text!.isEmpty {
            cell.headerView.containerStackViewBottomConstraint.constant = UIConstants.newsFeedButtonHeight + UIConstants.titleDateHeaderSpacing * 2
        } else {
            cell.headerView.containerStackViewBottomConstraint.constant = 0
        }
        cell.headerView.contentTextView.text = model.text
        cell.headerView.contentTextView.sizeToFit()
        cell.headerView.textViewHeightConstraint.constant = cell.headerView.contentTextView.contentSize.height
        cell.headerView.contentTextView.layoutIfNeeded()
        
        cell.footerView.loveLabel.text = formatNumber(model.likes?.count ?? 0)
        cell.footerView.commentsLabel.text = formatNumber(model.comments?.count ?? 0)
        cell.footerView.shareLabel.text = formatNumber(model.shares?.count ?? 0)
        
        cell.footerView.eyeLabel.text = formatNumber(model.views?.count ?? 0)
        cell.selectionStyle = .none
    }
    func getDateFromTimeInterval(date: Date) -> String {
        let dateFormatter: DateFormatter = {
            let date = DateFormatter()
            
            date.locale = Locale(identifier: "ru_RU")
            date.dateFormat = "d MMM 'в' HH:mm"
            
            return date
        }()
        
        return dateFormatter.string(from: date).replacingOccurrences(of: ".", with: "") // example from design - 27 апр в 20:39, NO dots
    }
    private func searchProfile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> HeaderRepresentable {
        let profilesOrGroups: [HeaderRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresenatable = profilesOrGroups.first { (myProfileRepresenatable) -> Bool in
            myProfileRepresenatable.id == normalSourceId
        }
        return profileRepresenatable!
    }
    private func formatNumber(_ n: Int) -> String {
        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)B"
            
        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)M"
            
        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)K"
            
        case 0...:
            return "\(n)"
            
        default:
            return "\(sign)\(n)"
        }
    }

}
