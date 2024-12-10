//
//  StorageViewPresenter.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/8/24.
//

import Foundation


protocol StoragePresenterProtocol: AnyObject {
    
    init(view: StorageVCProtocol, dataManager: DataManager, imageCacheManager: ImageCacheManager)
    func fetchAllFavouriteNews() -> [SavedNews]
    var news: [NewsFeedItems]? { get set }
    func deleteFavouriteNews(newsItem: SavedNews)
    func fetchImage(for urlString: String, completion: @escaping (Data?) -> Void)
    
}

class StoragePresenter: StoragePresenterProtocol {
    
    weak var view: StorageVCProtocol?
    let dataManager: DataManager
    let imageCacheManager: ImageCacheManager
    var news: [NewsFeedItems]?
    
    required init(view: StorageVCProtocol, dataManager: DataManager, imageCacheManager: ImageCacheManager) {
        self.view = view
        self.dataManager = dataManager
        self.imageCacheManager = imageCacheManager
    }
    
    func fetchAllFavouriteNews() -> [SavedNews] {
        return dataManager.fetchAllFavouriteNews()
    }
    
    
    func deleteFavouriteNews(newsItem: SavedNews) {
        newsItem.deleteFavouriteNews()
        print("Deleted item: \(newsItem.title ?? "unknown") from storage")
    }
    
    
    
}

extension StoragePresenter {
    
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


