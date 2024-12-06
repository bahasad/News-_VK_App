//
//  TabBarController.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabItems()
        
    }
    
    
    
    private func setupTabItems() {
        
        let newsFeedVC = UINavigationController(rootViewController: NewsFeedBuilder.build())
        newsFeedVC.tabBarItem.title = "Новости"
        newsFeedVC.tabBarItem.image = UIImage(systemName: "star")
        
        let errorNilVKVC = UINavigationController(rootViewController: ErrorNilVKVC())
        errorNilVKVC.tabBarItem.title = "Error Nil Vk"
        errorNilVKVC.tabBarItem.image = UIImage(named: "errorNilVk")
        
        let storageVC = UINavigationController(rootViewController:StorageVC())
        storageVC.tabBarItem.title = "Хранилище"
        storageVC.tabBarItem.image = UIImage(systemName: "star.fill")
  
        setViewControllers([ newsFeedVC,
                             errorNilVKVC,
                             storageVC,
                            ],
                            animated: false)
    }
}
