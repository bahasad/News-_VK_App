//
//  NewsFeedDetailsVC.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/7/24.
//

import UIKit
import Kingfisher

protocol NewsDetailsVCProtocol: AnyObject {
    
}

class NewsDetailsVC: UIViewController, NewsDetailsVCProtocol {
    
    private let newsItem: NewsFeedItems
    var presenter: NewsDetailsPresenterProtocol?
    
    private lazy var titleLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 0
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var descriptionLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var webBtn: UIButton = {
        $0.setTitle("Перейти на сайт", for: .normal)
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .black
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.addTarget(self, action: #selector(webBtnTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
        setUpWithNewsItem()
    }
    
    init(newsItem: NewsFeedItems) {
        self.newsItem = newsItem
        super.init(nibName: nil, bundle: nil)
    }
    
    private func addSubviews() {
        [imageView, titleLabel, descriptionLabel, webBtn].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 293),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            webBtn.heightAnchor.constraint(equalToConstant: 58),
            webBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -47),
            webBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            webBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            
        ])
    }
    
    private func setUpWithNewsItem() {
        titleLabel.text = newsItem.title
        descriptionLabel.text = newsItem.description
        if let imageUrl = URL(string: newsItem.imageUrl) {
            imageView.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "plus"))
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
    }
    
    @objc func webBtnTapped() {
        guard let url = URL(string: newsItem.url) else {
            print("Invalid URL")
            return
        }
        let webViewVC = WebViewVC(url: url)
        navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

