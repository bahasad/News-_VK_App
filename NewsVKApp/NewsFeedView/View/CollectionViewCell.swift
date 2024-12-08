//
//  NewsFeedCollectionViewCell.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/6/24.
//

import UIKit
import Kingfisher

protocol CollectionViewCellDelegate: AnyObject {
    
    func didTapStarButton(on cell: CollectionViewCell)
}

class CollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "CollectionViewCell"
    weak var delegate: CollectionViewCellDelegate?
    
    lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        return $0
    }(UIImageView())
    
    lazy var webSiteLabel = Components.label(weight: .bold)
    
    lazy var dateLabel = Components.label(color: UIColor.appGreyForFontLabel)
    
    lazy var titleLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 0
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    lazy var descLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .light)
        $0.numberOfLines = 0
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    lazy var starBtn: BookmarkButton = {
        let button = BookmarkButton(tintColor: .black)
            button.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
            return button
    }()
    
    var isBookmarked: Bool = false {
        didSet {
            starBtn.isBookmarked = isBookmarked
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.backgroundColor = .appColorLightGray
        contentView.layer.cornerRadius = 20
        setViews()
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
        starBtn.isBookmarked = false
    }
    
    private func setViews() {
        [ imageView, webSiteLabel, dateLabel, titleLabel, descLabel, starBtn ].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            starBtn.heightAnchor.constraint(equalToConstant: 25),
            starBtn.widthAnchor.constraint(equalToConstant: 25),
            starBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            starBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            
            webSiteLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            webSiteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            
            dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: webSiteLabel.trailingAnchor, constant: 13),
            
            titleLabel.topAnchor.constraint(equalTo: webSiteLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            descLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func setCellData(item: NewsFeedItems) {
        if let url = URL(string: item.imageUrl) {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "404notFound"))
        } else {
            imageView.image = UIImage(named: "imageForPlaceholder")
        }
        titleLabel.text = item.title
        descLabel.text = item.description
        webSiteLabel.text = Utilities.extractDomain(from: item.url)
        dateLabel.text =  Utilities.formatDate(from: item.publishedAt)
    }
    
    @objc func starButtonTapped() {
        delegate?.didTapStarButton(on: self)
    }
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

