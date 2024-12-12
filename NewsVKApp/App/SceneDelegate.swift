//
//  SceneDelegate.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/4/24.
//

import UIKit
import VKID


enum WindowCase {
    case login, home
}


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var vkid: VKID!
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(routeVC(notification:)), name: Notification.Name(rawValue: "routeVC"), object: nil)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        if UserDefaults.standard.bool(forKey: "isLogin") {
            self.window?.rootViewController = windowManager(vc: .login)
        } else {
            self.window?.rootViewController = windowManager(vc: .home)
        }
        window?.makeKeyAndVisible()
    }
    
    private func windowManager(vc: WindowCase) -> UIViewController {
        switch vc {
        case .login:
            return AuthModuleBuilder.build()
        case .home:
            return TabBarController()
        }
    }
    
    @objc func routeVC(notification: Notification) {
        guard let userInfo = notification.userInfo, let vc = userInfo["vc"] as? WindowCase else { return }
        self.window?.rootViewController = windowManager(vc: vc)
    }
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        URLContexts.forEach { ctx in
//            print("Received URL: \(ctx.url)")
//            self.vkid.open(url: ctx.url)
//        }
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    
}



