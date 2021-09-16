//
//  HeaderRepresentable.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import Foundation

protocol HeaderRepresentable {
    var id: Int { get }
    var title: String { get }
    var image: String { get }
}
