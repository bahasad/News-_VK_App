//
//  WebViewVC.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/7/24.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {

    private let url: URL

    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.navigationDelegate = self
        return webView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.color = .gray
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .large))

    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        loadURL()
    }

    private func setupViews() {
        webView.frame = view.bounds
        view.addSubview(webView)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }

    private func loadURL() {
        let request = URLRequest(url: url)
        activityIndicator.startAnimating()
        webView.load(request)
    }
}

extension WebViewVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Page loading....")
        activityIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Page loaded !@!")
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Failed to load page!@! : \(error.localizedDescription)")
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Nav error: \(error.localizedDescription)")
        activityIndicator.stopAnimating()
    }
}
