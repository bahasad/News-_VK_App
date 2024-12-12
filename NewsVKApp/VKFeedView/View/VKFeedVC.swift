//
//  ErrorNilVKVC.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import UIKit

protocol VKFeedVCProtocol: AnyObject {
    func updateNewsFeed(with data: [NewsFeedItems])
}

class VKFeedVC: UIViewController, VKFeedVCProtocol {
    
    
    
    
    var presenter: VKFeedPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func updateNewsFeed(with data: [NewsFeedItems]) {
        
    }
    
}

