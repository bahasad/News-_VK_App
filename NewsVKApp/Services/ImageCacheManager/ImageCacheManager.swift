//
//  ImageCacheManager.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/10/24.
//

import UIKit

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    private init() {}
    
    private let cache = NSCache<NSString, NSData>()
    
    func addImageToCache(imageData: Data, forKey key: String) {
        cache.setObject(imageData as NSData, forKey: key as NSString)
    }
    
    func getImageFromCache(forKey key: String) -> Data? {
        return cache.object(forKey: key as NSString) as Data?
    }
    
    func clearCache() {
            cache.removeAllObjects()
            print("[Info] Image cache cleared.")
        }
    
}

