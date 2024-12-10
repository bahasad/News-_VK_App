//
//  NewsFeedDetailsPresenter.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/7/24.
//

import Foundation


protocol NewsDetailsPresenterProtocol: AnyObject {
    init(view: NewsDetailsVCProtocol)
    
}

class NewsDetailsPresenter: NewsDetailsPresenterProtocol {
    
    weak var view: NewsDetailsVCProtocol?
    
    required init(view: NewsDetailsVCProtocol) {
        self.view = view
    }
    
}

