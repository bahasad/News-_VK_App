//
//  VKFeedCollectionViewCell.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/13/24.
//

import UIKit
import Kingfisher



class VKFeedCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "VKFeedCollectionViewCell"
    
    let components = Components()
    
    lazy var imageView = components.createImageView(clipsToBounds: true, cornerRadius: 20)
    
    lazy var webSiteLabel = Components.label(weight: .bold)
    
    lazy var dateLabel = Components.label(color: UIColor.appGreyForFontLabel)
    
    lazy var titleLabel = Components.label(size: 20, weight: .bold)
    
    lazy var descLabel = Components.label(size: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.backgroundColor = .appColorLightGray
        contentView.layer.cornerRadius = 20
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        [ imageView, webSiteLabel, dateLabel, titleLabel, descLabel ].forEach {
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
    
    func setCellData(item: VKWallItem) {
        titleLabel.text = item.text
        if let videoDesc = item.attachments?.first?.video?.description, !videoDesc.isEmpty {
            descLabel.text = videoDesc
        } else {
            descLabel.text = item.type
        }
        webSiteLabel.text = "vk.com"
        dateLabel.text = Utilities.formatDateForVKDate(from: item.attachments?.first?.video?.date)
        imageView.image = UIImage(systemName: "photo")
        
    }
    
  
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


