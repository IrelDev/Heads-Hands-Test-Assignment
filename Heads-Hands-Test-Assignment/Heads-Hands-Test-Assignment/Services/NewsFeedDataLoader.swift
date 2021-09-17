//
//  NewsFeedDataLoader.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 18.09.2021.
//

import Foundation

class NewsFeedDataLoader {
    weak var delegate: NewsFeedDataLoaderDelegate?
    
    func loadOldNews(startingFrom: String?, oldDataSource: FeedResponse?) {
        loadNews(startingFrom: startingFrom) { (feedResponse) in
            var dataSource = oldDataSource
            guard let feed = feedResponse else {
                return
            }
            guard startingFrom != feed.nextFrom else { return }
            
            let oldItemsCount = dataSource?.items.count ?? 0
            
            var startFetchingFrom: String?
            if dataSource == nil {
                dataSource = feed
            } else {
                dataSource?.items.append(contentsOf: feed.items)
                dataSource?.nextFrom = feed.nextFrom
                startFetchingFrom = feed.nextFrom
                
                var profiles = feed.profiles
                if let oldProfiles = dataSource?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter({ (oldProfile) -> Bool in
                        !feed.profiles.contains(where: { $0.id == oldProfile.id })
                    })
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                dataSource?.profiles = profiles
                
                var groups = feed.groups
                if let oldGroups = dataSource?.groups {
                    let oldGroupsFiltered = oldGroups.filter({ (oldGroup) -> Bool in
                        !feed.groups.contains(where: {$0.id == oldGroup.id})
                    })
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                dataSource?.groups = groups
            }
            
            guard let feedResponse = dataSource else { return }
            dataSource = feedResponse
            
            let indexPaths = (oldItemsCount ..< dataSource!.items.count).map { row in
                IndexPath(row: row , section: 0)
            }
            
            self.delegate?.oldDataLoaded(newDataSource: dataSource, newItems: indexPaths, startFetchingFrom: startFetchingFrom)
        }
    }
    func loadNews(startingFrom: String?, response: @escaping (FeedResponse?) -> Void) {
        var params = ["filters": "post"]
        params["start_from"] = startingFrom
        
        guard let url = APIMethod.news.getVKApiURL(with: params) else { return }
        
        NetworkService.shared.makeRequest(url: url) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error)")
                response(nil)
            }
            let decoded = NetworkService.shared.decodeJSON(type: WrappedFeedResponse.self, from: data)
            response(decoded?.response)
        }
    }
}

