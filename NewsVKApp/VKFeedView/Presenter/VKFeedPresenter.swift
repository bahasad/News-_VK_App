//
//  VKFeedPresenter.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/12/24.
//

import Foundation

protocol VKFeedPresenterProtocol: AnyObject {
    init(view: VKFeedVCProtocol, networkService: NetworkServiceProtocol, imageCacheManager: ImageCacheManager, keychainManager: KeychainManager)
    
}

class VKFeedPresenter: VKFeedPresenterProtocol {
    
    var view: VKFeedVCProtocol?
    let networkService: NetworkServiceProtocol
    let imageCacheManager: ImageCacheManager
    let keychainManager: KeychainManager
    
    required init(view: any VKFeedVCProtocol, networkService: any NetworkServiceProtocol, imageCacheManager: ImageCacheManager, keychainManager: KeychainManager) {
        self.view = view
        self.networkService = networkService
        self.imageCacheManager = imageCacheManager
        self.keychainManager = keychainManager
    }
    
    
   
    
}
