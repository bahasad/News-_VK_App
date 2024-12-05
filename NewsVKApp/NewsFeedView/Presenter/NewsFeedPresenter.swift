//
//  NewsFeedPresenter.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import Foundation

protocol NewsFeedPresenterProtocol: AnyObject {
    
}

class NewsFeedPresenter: NewsFeedPresenterProtocol {
    
    weak var view: NewsFeedVCProtocol?
    
    init(view: NewsFeedVCProtocol) {
        self.view = view
    }
}
