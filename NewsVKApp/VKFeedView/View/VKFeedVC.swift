//
//  ErrorNilVKVC.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import UIKit

protocol VKFeedVCProtocol: AnyObject {
    func updateNewsFeed(with data: [VKWallItems])
    
}

class VKFeedVC: UIViewController, VKFeedVCProtocol {
    
    
    
    
    
    
    
    
    var presenter: VKFeedPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchVKWallNews()
        presenter?.vkWallItems?.forEach({ item in
            print(item.text)
            print(item.date)
            print(item.attachments.count)
            item.attachments.forEach { item in
                item.photo
            }
            print(item.text)
            
        })
    }
    
    
    func updateNewsFeed(with data: [VKWallItems]) {
        
    }
    
}

