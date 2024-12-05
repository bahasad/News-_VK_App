//
//  AuthPresenter.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    func login(username: String, password: String)
    func viewDidLoad()
}

class AuthPresenter: AuthPresenterProtocol {
    
    weak var view: AuthViewProtocol?
    
    init(view: AuthViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        // Начальная настройка
    }
    
    
    func login(username: String, password: String) {
        // Логика для обработки логина
        if username == "user" && password == "password" {
            view?.showLoginSuccess()
        } else {
            view?.showLoginError(message: "Invalid credentials")
        }
    }
    
    
    
}

