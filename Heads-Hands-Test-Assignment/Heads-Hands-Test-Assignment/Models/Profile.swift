//
//  Profile.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import Foundation

struct Profile: HeaderRepresentable, Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var title: String { firstName + " " + lastName }
    var image: String { photo100 }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case photo100
    }
}
