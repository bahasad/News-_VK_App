//
//  VKWallResponse.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/12/24.
//

import Foundation

struct VKWallResponse: Codable {
    var response: VKWallData
}

struct VKWallData: Codable {
    var count: Int
    var items: [VKWallItem]
}

struct VKWallItem: Codable {
    let type: String
    let text: String
    let likes: VKLikes
    let views: VKViews
    let attachments: [VKAttachment]?
}

struct VKLikes: Codable {
    let count: Int
    let userLikes: Int
}

struct VKViews: Codable {
    let count: Int
}

struct VKAttachment: Codable {
    let type: String
    let video: VKVideo?
}

struct VKVideo: Codable {
    let description: String
    let date: Int
    let image: [VKImage]?
    let views: Int
}

struct VKImage: Codable {
    let url: String
    let width: Int
    let height: Int
}
