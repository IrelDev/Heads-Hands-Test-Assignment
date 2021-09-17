//
//  NewsFeedDataLoaderDelegate.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 18.09.2021.
//

import Foundation

protocol NewsFeedDataLoaderDelegate: AnyObject {
    func oldDataLoaded(newDataSource: FeedResponse?, newItems: [IndexPath], startFetchingFrom: String?)
}
