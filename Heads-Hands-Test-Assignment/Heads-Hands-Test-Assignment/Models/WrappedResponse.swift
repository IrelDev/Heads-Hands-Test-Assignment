//
//  WrappedResponse.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 18.09.2021.
//

import Foundation

struct WrappedResponse<Response: Codable>: Codable {
    let response: Response?
}
