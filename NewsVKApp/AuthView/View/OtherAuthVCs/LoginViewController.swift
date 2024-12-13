//
//  LoginViewController.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/11/24.
//
import UIKit
import VKID

class LoginViewController: UIViewController {

    private var vkid: VKID!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        do {
            vkid = try VKID(
                config: Configuration(
                    appCredentials: AppCredentials(
                        clientId: "52808544",
                        clientSecret: "R1Pa3PoVueQYgPVX1iSn"
                    )
                )
            )
        } catch {
            preconditionFailure("Failed to initialize VKID: \(error)")
        }
        let oneTap = OneTapButton(
            appearance: .init(
                style: .primary(),
                theme: .matchingColorScheme(.system)
            ),
            layout: .regular(
                height: .large(.h56),
                cornerRadius: 28
            ),
            presenter: .newUIWindow
        ) { authResult in
            do {
                let session = try authResult.get()
                print("Auth succeeded with token: \(session.accessToken)")
            } catch AuthError.cancelled {
                print("Auth cancelled by user")
            } catch {
                print("Auth failed with error: \(error)")
            }
        }
        let oneTapView = vkid.ui(for: oneTap).uiView()
        oneTapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(oneTapView)
        NSLayoutConstraint.activate([
            oneTapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            oneTapView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            oneTapView.widthAnchor.constraint(equalToConstant: 300),
            oneTapView.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
