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
        let networkService = NetworkManager()
        let dataManager = DataManager()
        let presenter = NewsFeedPresenter(view: view, networkService: networkService, dataManager: dataManager)
        view.presenter = presenter
        return view
    }
}
