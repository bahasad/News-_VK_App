//
//  NetworkManager.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchAllNews() async throws -> [NewsFeedItems]
    func fetchNewsBySearchWord(searchWord: String) async throws -> [NewsFeedItems]
    func fetchUserNameAndAvatarFromVK(token: String) async throws -> [VKUserDataItems]
    func fetchNewsFromVK(token: String) async throws -> [VKWallItem]
}

class NetworkManager: NetworkServiceProtocol {
    
    static let shared = NetworkManager()
    private init() {}
    
    
    func getRandomCategory() -> String? {
        let categories = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
        return categories.randomElement()
    }
    
    func fetchAllNews() async throws -> [NewsFeedItems] {
        
        
        //GET https://api.thenewsapi.com/v1/news/all?api_token=bqZeKyiP8mTUuy5DKfGLHNZuna6wtfLyrnZ77nEj&search=usd
        //GET https://api.thenewsapi.com/v1/news/headlines HTTP/1.1
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.thenewsapi.com"
        urlComponents.path = "/v1/news/all"
        
        urlComponents.queryItems = [ URLQueryItem(name: "api_token", value: "bqZeKyiP8mTUuy5DKfGLHNZuna6wtfLyrnZ77nEj"),
                                     URLQueryItem(name: "locale", value: "us"),
                                     URLQueryItem(name: "language", value: "en"),
                                     URLQueryItem(name: "categories", value: getRandomCategory()),
        ]//token with 8777432
        //urlComponents.queryItems = [ URLQueryItem(name: "api_token", value: "bqZeKyiP8mTUuy5DKfGLHNZuna6wtfLyrnZ77nEj") ]//token with bak906
        //cZNaMjVdxl441OOeOsWsrA9QwhSom7rykLIpmIyK    - token with 8777432
        
        return try await performRequest(urlComponents, decodeType: NewsFeedResponse.self).data
    }
    
    
    
    func fetchNewsBySearchWord(searchWord: String) async throws -> [NewsFeedItems] {
        
        
        //GET https://api.thenewsapi.com/v1/news/all?api_token=bqZeKyiP8mTUuy5DKfGLHNZuna6wtfLyrnZ77nEj&search=usd
        //GET https://api.thenewsapi.com/v1/news/headlines HTTP/1.1
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.thenewsapi.com"
        urlComponents.path = "/v1/news/all"
        
        urlComponents.queryItems = [ URLQueryItem(name: "api_token", value: "bqZeKyiP8mTUuy5DKfGLHNZuna6wtfLyrnZ77nEj"),
                                     URLQueryItem(name: "search", value: searchWord)
        ]
        
        return try await performRequest(urlComponents, decodeType: NewsFeedResponse.self).data
    }
    
    func fetchUserNameAndAvatarFromVK(token: String) async throws -> [VKUserDataItems] {
        
        //https://api.vk.com/method/users.get?fields=photo_200,first_name,last_name&access_token=YOUR_ACCESS_TOKEN&v=5.131
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/users.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "fields", value: "photo_200,first_name,last_name"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        return try await performRequest(urlComponents, decodeType: VKUserDataItemsResponse.self).response
    }
    
    func fetchNewsFromVK(token: String) async throws -> [VKWallItem] {
        
        //https://api.vk.com/method/wall.get?owner_id=87492249&access_token=YOUR_ACCESS_TOKEN&v=5.131
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/wall.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "-222251367"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        return try await performRequest(urlComponents, decodeType: VKWallResponse.self).response.items
    }
    
    
    private func performRequest<T: Decodable>(_ endpoint: URLComponents, decodeType: T.Type) async throws -> T {
            guard let url = endpoint.url else {
                throw CustomError.invalidURL
            }
            
            let urlRequest = URLRequest(url: url)
            print("[Info] URLRequest: \(urlRequest)")
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("[Error] Invalid response code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                throw CustomError.invalidResponse
            }
            
            if let rawJson = String(data: data, encoding: .utf8) {
                print("[Info] Raw JSON Data: \n\(rawJson)")
            } else {
                print("[Error] Unable to convert data to string")
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                return try decoder.decode(decodeType, from: data)
            } catch {
                print("[Error] Decoding failed: \(error)")
                throw CustomError.invalidData
            }
        }
    
}

enum CustomError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}



