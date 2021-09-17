//
//  Group.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import Foundation

struct Group: HeaderRepresentable, Codable {
    let id: Int
    let name: String
    let photo100: String
    
    var title: String { name }
    var image: String { photo100 }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo100
    }
}
