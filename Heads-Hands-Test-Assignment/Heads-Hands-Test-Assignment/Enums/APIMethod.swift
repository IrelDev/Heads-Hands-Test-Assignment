//
//  APIMethod.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import Foundation
import VKSdkFramework

enum APIMethod: String {
    case news = "/method/newsfeed.get"
    case video = "/method/video.get"
}
extension APIMethod {
    func getVKApiURL(with parameters: [String: String] = [:]) -> URL? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = rawValue
        
        var allParameters = parameters
        allParameters["v"] = "5.131"
        allParameters["access_token"] = VKSdk.accessToken()?.accessToken
        
        components.queryItems = allParameters.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        return components.url
    }
}
