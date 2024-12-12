//
//  SavedNews+CoreDataClass.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/10/24.
//
//

import Foundation
import CoreData

@objc(SavedNews)
public class SavedNews: NSManagedObject {

}
extension SavedNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedNews> {
        return NSFetchRequest<SavedNews>(entityName: "SavedNews")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var pathToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}

extension SavedNews : Identifiable {

}

extension SavedNews {
    
    func deleteFavouriteNews(){
        guard let context = managedObjectContext else {
            print("error: managedobject context is nil")
            return
        }
        context.delete(self)
        do {
            try context.save()
            print("success deleted the news item")
        } catch {
            print("failed to delete the news item: \(error.localizedDescription)")
        }
    }
}

