//
//  StorageVC.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import UIKit

protocol StorageVCProtocol: AnyObject {
    
}

class StorageVC: UIViewController, StorageVCProtocol {
    
    var presenter: StoragePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

