//
//  StorageViewPresenter.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/8/24.
//

import Foundation


protocol StoragePresenterProtocol: AnyObject {
    
    init(view: StorageVCProtocol, dataManager: DataManager)
    func fetchAllFavouriteNews() -> [SavedNews]
    
}

class StoragePresenter: StoragePresenterProtocol {
    
    
    weak var view: StorageVCProtocol?
    let dataManager: DataManager
    
    required init(view: StorageVCProtocol, dataManager: DataManager) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func fetchAllFavouriteNews() -> [SavedNews] {
        return dataManager.fetchAllFavouriteNews()
    }
    
    
    
}

