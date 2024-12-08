//
//  StorageHeaderView.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/8/24.
//

import UIKit

class StorageHeaderView: UICollectionReusableView {
    
    static let reuseId = "StorageHeaderView"
    
    private let headerLabel = Components.label(size: 34, weight: .bold, textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headerLabel.text = "Хранилище"
        addSubview(headerLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

