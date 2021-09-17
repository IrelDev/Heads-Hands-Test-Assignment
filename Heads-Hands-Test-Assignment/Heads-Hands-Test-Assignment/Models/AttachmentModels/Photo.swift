//
//  Photo.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import Foundation

struct Photo: Codable {
    let sizes: [PhotoSize]

    var url: String {
        getProperPhotoSize().url
    }

    var width: Int {
        getProperPhotoSize().width
    }

    var height: Int {
        getProperPhotoSize().height
    }

    private func getProperPhotoSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
             return fallBackSize
        } else {
            return PhotoSize(type: "", url: "", width: 0, height: 0)
        }
    }
}
