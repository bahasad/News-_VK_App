//
//  VKWallResponse.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/12/24.
//

import Foundation

struct VKWallResponse: Codable {
    var response: Response
}

struct Response: Codable {
    var count: Int
    var items: [VKWallItems]
}

struct VKWallItems: Codable {
    var id: Int
    var date: String
    var text: String
    var attachments: [Attachments]
}

struct Attachments: Codable {
    var photo: Photo
}

struct Photo: Codable {
    var sizes: [Sizes]
}

struct Sizes: Codable {
    var type: String
    var url: String
}
