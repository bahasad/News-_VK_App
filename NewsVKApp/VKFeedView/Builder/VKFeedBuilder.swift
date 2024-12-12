//
//  VKFeedBuilder.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/12/24.
//

import UIKit

class VKFeedBuilder {
    
    static func build() -> UIViewController {
        let view = VKFeedVC()
        let networkService = NetworkManager.shared
        let imageCacheManager = ImageCacheManager.shared
        let keychainManager = KeychainManager.shared
        let presenter = VKFeedPresenter(view: view, networkService: networkService, imageCacheManager: imageCacheManager, keychainManager: keychainManager)
        view.presenter = presenter
        return view
    }
}

