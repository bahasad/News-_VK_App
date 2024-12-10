//
//  StorageViewBuilder.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/8/24.
//

import UIKit

class StorageBuilder {
    
    static func build() -> UIViewController {
        let view = StorageVC()
        let dataManager = DataManager()
        let imageCacheManager = ImageCacheManager.shared
        let presenter = StoragePresenter(view: view, dataManager: dataManager, imageCacheManager: imageCacheManager)
        view.presenter = presenter
        return view
    }
    
}
