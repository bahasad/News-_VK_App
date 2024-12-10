//
//  NewsFeedDetailsBuilder.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/7/24.
//

import UIKit

class NewsDetailsBuilder {
    
    static func build(newsItem: NewsFeedItems) -> UIViewController {
        let view = NewsDetailsVC(newsItem: newsItem)
        let presenter = NewsDetailsPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
