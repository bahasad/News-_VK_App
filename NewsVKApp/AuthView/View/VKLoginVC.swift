//
//  AuthViewController.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//
import UIKit
@preconcurrency import WebKit


protocol VKAuthVCProtocol: AnyObject {
    
}

class VKAuthVC: UIViewController, WKNavigationDelegate, VKAuthVCProtocol {
    
    var presenter: AuthPresenterProtocol?
    
    private lazy var webView: WKWebView = {
        $0.navigationDelegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(WKWebView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VKLoginViewController viewDidLoad: Initialized")
        
        setupWebView()
        loadVKAuthPage()
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //to presenter
    private func loadVKAuthPage() {
        print("VKLoginViewController loadVKAuthPage: Preparing VK OAuth URL")
        guard let url = presenter?.loadVKAuthPage() else {
            return
        }
        print("VKLoginViewController loadVKAuthPage: Loading URL \(url)")
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let url = navigationResponse.response.url {
            print("Full URL: \(url)")
            if url.absoluteString.contains("access_token"), url.path == "/blank.html", let fragment = url.fragment {
                print("URL fragment: \(fragment)")
                if let token = presenter?.extractAccessToken(from: fragment) {
                    print("Extracted Access Token: \(token)")
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    print("User defaults for isLogin set to true")
                    presenter?.saveTokenToKeychain(token: token)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "routeVC"), object: nil, userInfo: ["vc": WindowCase.home])
                }
                decisionHandler(.cancel)
                dismiss(animated: true) {
                    print("VKLoginViewController: Dismissed after retrieving token")
                }
                return
            }
        }
        decisionHandler(.allow)
    }
    
    
    
    
}

