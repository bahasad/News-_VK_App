//
//  AuthModuleBuilder.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import UIKit

class AuthModuleBuilder {
    
    static func build() -> UIViewController {
        let view = VKAuthVC()
        let keychainManager = KeychainManager.shared
        let presenter = AuthPresenter(view: view, keychainManager: keychainManager)
        view.presenter = presenter
        return view
    }
}
