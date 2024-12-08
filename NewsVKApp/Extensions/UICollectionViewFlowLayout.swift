//
//  Ext.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/8/24.
//


import UIKit

extension UICollectionViewFlowLayout {
    static func createLayout(cellHeight: CGFloat = 500, interitemSpacing: CGFloat = 10, lineSpacing: CGFloat = 20, insets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = interitemSpacing
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = insets
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth - insets.left - insets.right - 30
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.headerReferenceSize = CGSize(width: screenWidth, height: 60)
        return layout
    }
}

