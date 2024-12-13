//
//  VKFeedPresenter.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/12/24.
//

import Foundation

protocol VKFeedPresenterProtocol: AnyObject {
    init(view: VKFeedVCProtocol, networkService: NetworkServiceProtocol, imageCacheManager: ImageCacheManager, keychainManager: KeychainManager)
    func fetchVKWallNews()
    var vkWallItems: [VKWallItems]? {get}
    
}

class VKFeedPresenter: VKFeedPresenterProtocol {
    
    var view: VKFeedVCProtocol?
    let networkService: NetworkServiceProtocol
    let imageCacheManager: ImageCacheManager
    let keychainManager: KeychainManager
    var vkWallItems: [VKWallItems]?
    
    required init(view: any VKFeedVCProtocol, networkService: any NetworkServiceProtocol, imageCacheManager: ImageCacheManager, keychainManager: KeychainManager) {
        self.view = view
        self.networkService = networkService
        self.imageCacheManager = imageCacheManager
        self.keychainManager = keychainManager
        fetchVKWallNews()
    }
    
    func fetchVKWallNews() {
        let token = keychainManager.retrieveTokenFromKeychain() ?? ""
        Task {
            do {
                vkWallItems = try await networkService.fetchNewsFromVK(token: token)
                DispatchQueue.main.async { [weak self] in
                    self?.view?.updateNewsFeed(with: self?.vkWallItems ?? [])
                }
            } catch CustomError.invalidURL {
                print("invalid URL")
            } catch CustomError.invalidResponse {
                print("invalid Response")
            } catch CustomError.invalidData {
                print("invalid Data")
            } catch {
                print("unexpected error")
            }
        }
    }
    
//    func fetchNewsFromVK(token: String) async throws -> [VKWallItems] {
//        
//    }
//    
    
   
    
}
