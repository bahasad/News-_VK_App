//
//  StorageCollectionViewCell.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/9/24.
//


import UIKit
import Kingfisher


protocol StorageCollectionViewCellDelegate: AnyObject {
    
    func didTapStarButton(on cell: StorageCollectionViewCell)
}


class StorageCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "StorageCollectionViewCell"
    
    weak var delegate: StorageCollectionViewCellDelegate?
    
    lazy var imageView = Components.imageView(cornerRadius: 20)
    
    lazy var webSiteLabel = Components.label(weight: .bold)
    
    lazy var dateLabel = Components.label(color: UIColor.appGreyForFontLabel)
    
    lazy var titleLabel = Components.label(size: 29, weight: .bold, textAlignment: .left)
    
    lazy var descLabel = Components.label(size: 16, weight: .light, textAlignment: .left)
    
    lazy var starBtn: UIButton = {
        $0.tintColor = UIColor.black
        $0.setImage( UIImage(systemName: "star.fill"), for: .normal)
        $0.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.backgroundColor = .appColorLightGray
        contentView.layer.cornerRadius = 20
        setViews()
        setConstraints()
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
 
    func setCellData(item: SavedNews) {
        
        titleLabel.text = item.title
        descLabel.text = item.desc
        dateLabel.text = Utilities.formatDate(from: item.publishedAt)
        webSiteLabel.text = Utilities.extractDomain(from: item.url)
        if let url = URL(string: item.imageUrl ?? "") {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "404notFound"))
        } else {
            imageView.image = UIImage(named: "imageForPlaceholder")
        }
    }
    
    @objc func starButtonTapped() {
        delegate?.didTapStarButton(on: self)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



