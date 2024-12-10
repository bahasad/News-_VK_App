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
    
    
    private lazy var headerLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.text = "Новость"
        return $0
    }(UILabel())
    
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
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    lazy var webSiteLabel = Components.label(color: .white)
    
    lazy var dateLabel = Components.label(color: .white)
    
    
    private lazy var webBtn: UIButton = {
        $0.setTitle("Перейти на сайт", for: .normal)
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .black
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.addTarget(self, action: #selector(webBtnTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var gradientView: UIView = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        $0.layer.addSublayer(gradientLayer)
        return $0
    }(UIView())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
        setUpWithNewsItem()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = gradientView.bounds
        }
    }
    
    init(newsItem: NewsFeedItems) {
        self.newsItem = newsItem
        super.init(nibName: nil, bundle: nil)
    }
    
    private func addSubviews() {
        [ imageView, gradientView, titleLabel, webSiteLabel, dateLabel, descriptionLabel, webBtn, headerLabel ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 293),
            
            gradientView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            gradientView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.3),
            
            webSiteLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 28),
            webSiteLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -28),
            
            dateLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -28),
            dateLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -28),
            
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
        
        webSiteLabel.text = Utilities.extractDomain(from: newsItem.url)
        dateLabel.text =  Utilities.formatDate(from: newsItem.publishedAt)
        titleLabel.text = newsItem.title
        descriptionLabel.text = newsItem.description
        if let imageUrl = URL(string: newsItem.imageUrl) {
            imageView.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "plus"))
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
    }
    
    @objc func webBtnTapped() {
        guard let urlString = newsItem.url,
              let url = URL(string: urlString) else {
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

