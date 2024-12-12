//
//  KeychainManager.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/12/24.
//

import Foundation
import KeychainSwift

class KeychainManager {
    
    var accessToken = "accessToken"
    static let shared = KeychainManager()
    private init(){}
    
    let keychain = KeychainSwift()
    
    func saveTokenToKeychain(token: String){
        keychain.set(token, forKey: accessToken)
    }
    
    func retrieveTokenFromKeychain() -> String? {
        if let token = keychain.get(accessToken) {
            print("Retrieve token: \(token)")
            return token
        } else {
            print("No token found")
            return nil
        }
    }
    
    func deleteTokenFromKeychain() {
        keychain.delete(accessToken)
        print("Access Token was deleted")
    }
    
    
    
    
}

