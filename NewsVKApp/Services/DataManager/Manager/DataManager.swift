//
//  StorageManager.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import Foundation
import CoreData

class DataManager {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = DBStore.shared.persistentContainer.viewContext){
        self.context = context
    }
    
    func saveNews(newsItem: NewsFeedItems) {
        
        let favouriteItem = SavedNews(context: context)
        favouriteItem.id = newsItem.uuid
        favouriteItem.title = newsItem.title
        favouriteItem.desc = newsItem.description
        favouriteItem.imageUrl = newsItem.imageUrl
        favouriteItem.url = newsItem.url
        favouriteItem.publishedAt = newsItem.publishedAt
        do {
            try context.save()
            print("News item saved success!")
        } catch {
            print("Failed to save item news: \(error.localizedDescription)")
        }
    }
    
    func fetchAllFavouriteNews() -> [SavedNews] {
        let req: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
        do {
            let savedNews = try context.fetch(req)
            return savedNews
        } catch {
            print("Failed to save item news: \(error.localizedDescription)")
            return []
        }
    }
    
    
    
}

