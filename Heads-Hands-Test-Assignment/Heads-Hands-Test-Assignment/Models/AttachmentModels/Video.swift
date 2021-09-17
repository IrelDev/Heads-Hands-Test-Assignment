//
//  Video.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import Foundation

struct Video: Codable {
    let id: Int
    let ownerId: Int
    let duration: Int
    let image: [Image]
    let accessKey: String?
    var imageUrl: String {
        getProperImage().url
    }

    var imageWidth: Int {
        getProperImage().width
    }

    var imageHeight: Int {
        getProperImage().height
    }

    private func getProperImage() -> Image {
        if let size640 = image.first(where: { $0.width == 640 }) {
            return size640
        } else if let size320 = image.first(where: { $0.width == 320 }) {
             return size320
        } else {
            return Image(url: "", width: 0, height: 0)
        }
    }
}
