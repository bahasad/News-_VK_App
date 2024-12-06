//
//  NewsFeedCollectionViewCell.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/6/24.
//

import UIKit
import Kingfisher

protocol NewsFeedCollectionViewCellDelegate: AnyObject {
    
    func didTapStarButton(on cell: NewsFeedCollectionViewCell)
}

class NewsFeedCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "NewsFeedCollectionViewCell"
    weak var delegate: NewsFeedCollectionViewCellDelegate?
    
    lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        return $0
    }(UIImageView())
    
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
    
    lazy var starBtn: UIButton = {
        $0.setImage(UIImage(systemName: "star"), for: .normal)
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
        [ imageView, titleLabel, descLabel, starBtn ].forEach {
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
            starBtn.heightAnchor.constraint(equalToConstant: 21),
            starBtn.widthAnchor.constraint(equalToConstant: 21),
            starBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            starBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
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
    }
    
    @objc func starButtonTapped() {
        delegate?.didTapStarButton(on: self)
    }
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

