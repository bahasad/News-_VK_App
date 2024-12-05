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
        let presenter = NewsFeedPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
