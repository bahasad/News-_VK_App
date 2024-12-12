//
//  WidgetAuthViewController.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/11/24.
//

import UIKit
import VKID

class WidgetAuthViewController: UIViewController {

    private var vkid: VKID!
    
    private lazy var authLabel: UILabel = {
        $0.text = "Voiti s pomoshiu:"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(authLabel)
        
        
        
        do {
            vkid = try VKID(
                config: Configuration(
                    appCredentials: AppCredentials(
                        clientId: "52808544",
                        clientSecret: "R1Pa3PoVueQYgPVX1iSn"
                    )
                )
            )
            print("VKID SDK initialized successfully")
        } catch {
            preconditionFailure("Failed to initialize VKID: \(error)")
        }

        
        let authConfiguration = AuthConfiguration(
            flow: .publicClientFlow(),
            scope: ["email"]
        )
        let oAuthListWidget = OAuthListWidget(
            oAuthProviders: [.mail, .ok],
            authConfiguration: authConfiguration,
            buttonConfiguration: .init(
                height: .medium(.h44),
                cornerRadius: 8.0
            ),
            theme: .matchingColorScheme(.system),
            presenter: .newUIWindow
        ) { [weak self] authResult in
            do {
                let session = try authResult.get()
                let accessToken = session.accessToken
                let tokenValue = accessToken.value
                print("Auth succeeded with token: \(tokenValue)")
                UserDefaults.standard.set(tokenValue, forKey: "VKAccessToken")

                
                DispatchQueue.main.async {
                    self?.redirectToTabBarController()
                }
            } catch AuthError.cancelled {
                print("Auth cancelled by user")
            } catch {
                print("Auth failed with error: \(error)")
            }
        }

        
        let oAuthListWidgetView = vkid.ui(for: oAuthListWidget).uiView()
        oAuthListWidgetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(oAuthListWidgetView)
        NSLayoutConstraint.activate([
            authLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),

            oAuthListWidgetView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            oAuthListWidgetView.topAnchor.constraint(equalTo: authLabel.bottomAnchor, constant: 20),
            oAuthListWidgetView.widthAnchor.constraint(equalToConstant: 250),
            oAuthListWidgetView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func redirectToTabBarController() {
        let tabBarController = TabBarController()
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = tabBarController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
}
