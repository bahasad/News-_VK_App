//
//  NewsFeedBuilder.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import UIKit

class NewsFeedBuilder {
    
    static func build() -> UIViewController {
        let view = NewsFeedVC()
        let networkService = NetworkManager.shared
        let dataManager = DataManager()
        let imageCacheManager = ImageCacheManager.shared
        let keychainManager = KeychainManager.shared
        let presenter = NewsFeedPresenter(view: view, networkService: networkService, dataManager: dataManager, imageCacheManager: imageCacheManager, keychainManager: keychainManager)
        view.presenter = presenter
        return view
    }
}
