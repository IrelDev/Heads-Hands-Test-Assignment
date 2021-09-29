//
//  FeedResponse.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 29.09.2021.
//

import Foundation

struct FeedResponse: Codable {
    var items: [FeedItem]
    var profiles: [Profile]
    var groups: [Group]
    var nextFrom: String?
}
