//
//  AuthPresenter.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    
    init(view: VKAuthVCProtocol, keychainManager: KeychainManager)
    func loadVKAuthPage() -> URL?
    func extractAccessToken(from fragment: String) -> String?
    func saveTokenToKeychain(token: String)
    func retrieveTokenFromKeychain() -> String?
    func deleteTokenFromKeychain()
    
}

class AuthPresenter: AuthPresenterProtocol {
    
    weak var view: VKAuthVCProtocol?
    let keychainManager: KeychainManager
    
    required init(view: VKAuthVCProtocol, keychainManager: KeychainManager) {
        self.view = view
        self.keychainManager = keychainManager
    }
    
    internal func loadVKAuthPage() -> URL? {
        let appID = "52808544"
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: appID),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token")
        ]
        guard let url = urlComponents.url else {
            print("VKLoginViewController loadVKAuthPage: Invalid URL")
            return nil
        }
        return url
    }
    
    internal func extractAccessToken(from fragment: String) -> String? {
        print("Parsing fragment: \(fragment)")
        let params = fragment.split(separator: "&").reduce(into: [String: String]()) { result, pair in
            let keyValue = pair.split(separator: "=")
            if keyValue.count == 2 {
                result[String(keyValue[0])] = String(keyValue[1])
            }
        }
        print("Parsed Params: \(params)")
        return params["access_token"]
    }
    
    func saveTokenToKeychain(token: String) {
        KeychainManager.shared.saveTokenToKeychain(token: token)
        print("access token saved!")
    }
    
    func retrieveTokenFromKeychain() -> String? {
        return KeychainManager.shared.retrieveTokenFromKeychain()
    }
    
    func deleteTokenFromKeychain() {
        KeychainManager.shared.deleteTokenFromKeychain()
    }
    
    
    
}

