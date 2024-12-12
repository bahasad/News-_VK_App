//
//  VKUserDataItems.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/12/24.
//


import Foundation

struct VKUserDataItemsResponse: Codable {
    var response: [VKUserDataItems]
}

struct VKUserDataItems: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var photo200: String
}
