//
//  NewsFeedItems.swift.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import Foundation

struct NewsFeedResponse: Codable {
    //var meta: Meta
    var data: [NewsFeedItems]
}

//struct Meta: Codable {
//    
//}


struct NewsFeedItems: Codable {
    var uuid: String
    var title: String
    var description: String
    var url: String
    var imageUrl: String
}
