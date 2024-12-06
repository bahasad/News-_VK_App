//
//  NewsFeedItems.swift.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import Foundation

struct NewsFeedResponse: Codable {
    var data: [NewsFeedItems]
}


struct NewsFeedItems: Codable {
    var uuid: String
    var title: String
    var description: String
    var url: String
    var imageUrl: String
}
