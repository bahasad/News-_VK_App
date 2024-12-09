//
//  Untitled.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/9/24.
//


import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    func path() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first
        return urls!
    }
    
    func saveFile(file: Data, id: String) {
        let path = path()
        let photoURL = path.appending(path: "photos")
        
        do {
            try FileManager.default.createDirectory(at: photoURL, withIntermediateDirectories: true)
        } catch {
            print("error creating directory: \(error.localizedDescription)")
        }
        
        let imageUrl = photoURL.appending(path: "\(id).jpg")
        
        do {
            try file.write(to: imageUrl)
        } catch {
            print("error writing  to file: \(error.localizedDescription)")
        }
    }
    
    func readFile(id: String) -> Data? {
        let path = path().appending(path: "photos").appending(path: "\(id).jpg")
        let data = try? Data(contentsOf: path)
        return data
    }
    
}

//var imageView = UIIMageView()
//let imgData = storage.readFile() {
//  imageView.image = UIImage(data: imgData
//  }






//if let imgData = image.jpegData(compressionQuality: 0.5) {
//    storage.saveFile(file: imgData)
//}
