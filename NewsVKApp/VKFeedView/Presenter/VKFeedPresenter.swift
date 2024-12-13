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
    var vkWallItems: [VKWallItem]? {get}
    func deleteTokenFromKeychain()
    func fetchImage(for urlString: String, completion: @escaping (Data?) -> Void)
    
}

class VKFeedPresenter: VKFeedPresenterProtocol {
    
    weak var view: VKFeedVCProtocol?
    let networkService: NetworkServiceProtocol
    let imageCacheManager: ImageCacheManager
    let keychainManager: KeychainManager
    var vkWallItems: [VKWallItem]?
    var vkUserItems: [VKUserDataItems]?
    
    required init(view: any VKFeedVCProtocol, networkService: any NetworkServiceProtocol, imageCacheManager: ImageCacheManager, keychainManager: KeychainManager) {
        self.view = view
        self.networkService = networkService
        self.imageCacheManager = imageCacheManager
        self.keychainManager = keychainManager
        fetchVKWallNews()
        fetchUserNameAndAvatar()
    }
    
    func fetchUserNameAndAvatar() {
        let token = keychainManager.retrieveTokenFromKeychain() ?? ""
        Task {
            do {
                vkUserItems = try await networkService.fetchUserNameAndAvatarFromVK(token: token)
                DispatchQueue.main.async { [weak self] in
                    self?.view?.updateVKUserDetails(with: self?.vkUserItems ?? [])
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
    
}
extension VKFeedPresenter {
    
    func deleteTokenFromKeychain() {
        keychainManager.deleteTokenFromKeychain()
    }
}

extension VKFeedPresenter {
    
    func fetchImage(for urlString: String, completion: @escaping (Data?) -> Void) {
        if let cachedData = imageCacheManager.getImageFromCache(forKey: urlString) {
            completion(cachedData)
            return
        }
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        DispatchQueue.global(qos: .utility).async {
            do {
                let data = try Data(contentsOf: url)
                self.imageCacheManager.addImageToCache(imageData: data, forKey: urlString)
                DispatchQueue.main.async {
                    completion(data)
                }
            } catch {
                print("Failed to fetch image: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}




