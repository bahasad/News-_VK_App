//
//  NewsFeedVC.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import UIKit

protocol NewsFeedVCProtocol: AnyObject {
    
}

class NewsFeedVC: UIViewController, NewsFeedVCProtocol  {
    
    var presenter: NewsFeedPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

