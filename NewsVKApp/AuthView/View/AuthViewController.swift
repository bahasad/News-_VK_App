//
//  AuthViewController.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import UIKit


protocol AuthViewProtocol: AnyObject {
    func showLoginSuccess()
    func showLoginError(message: String)
}


class AuthViewController: UIViewController, AuthViewProtocol {
    
    var presenter: AuthPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter?.viewDidLoad()    
    }
    
    
    func showLoginSuccess() {
        print("Login successful")
    }
    
    func showLoginError(message: String) {
        print("Login failed: \(message)")
    }
    
}
