//
//  FeedItem.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import Foundation

struct FeedItem: Codable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: Count?
    let likes: Count?
    let shares: Count?
    let views: Count?
    let attachments: [Attachment]?
}
