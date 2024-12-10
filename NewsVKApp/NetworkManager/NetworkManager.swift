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
}

class NetworkManager: NetworkServiceProtocol {
    
    
    func fetchAllNews() async throws -> [NewsFeedItems] {
        
        
        //GET https://api.thenewsapi.com/v1/news/all?api_token=bqZeKyiP8mTUuy5DKfGLHNZuna6wtfLyrnZ77nEj&search=usd
        //GET https://api.thenewsapi.com/v1/news/headlines HTTP/1.1
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.thenewsapi.com"
        urlComponents.path = "/v1/news/all"
        
        urlComponents.queryItems = [ URLQueryItem(name: "api_token", value: "cZNaMjVdxl441OOeOsWsrA9QwhSom7rykLIpmIyK") ]//token with 8777432
        //urlComponents.queryItems = [ URLQueryItem(name: "api_token", value: "bqZeKyiP8mTUuy5DKfGLHNZuna6wtfLyrnZ77nEj") ]//token with bak906
        
        guard let url = urlComponents.url else {
            throw CustomError.invalidURL
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        if response.statusCode != 200 {
            print("HTTP Status Code: \(response.statusCode)")
            throw CustomError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        let result: NewsFeedResponse
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            result = try decoder.decode(NewsFeedResponse.self, from: data)
        } catch {
            throw CustomError.invalidData
        }
        return result.data
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
        
        guard let url = urlComponents.url else {
            throw CustomError.invalidURL
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        let result: NewsFeedResponse
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            result = try decoder.decode(NewsFeedResponse.self, from: data)
        } catch {
            throw CustomError.invalidData
        }
        return result.data
    }
    
}

enum CustomError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}



