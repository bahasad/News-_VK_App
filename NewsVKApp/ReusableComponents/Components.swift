//
//  Components.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/7/24.
//

import UIKit

class Components {
    
    static func label(size: CGFloat = 14, numberOfLines: Int = 0, weight: UIFont.Weight = .light, color: UIColor = .black, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.numberOfLines = numberOfLines
        label.textColor = color
        label.textAlignment = textAlignment
        return label
    }
    
    static func imageView(contentMode: UIView.ContentMode = .scaleAspectFill, cornerRadius: CGFloat = 0) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = contentMode
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
        return imageView
    }
    
    func createImage(named image: String, contentMode: UIView.ContentMode = .scaleAspectFill, clipsToBounds: Bool = false, cornerRadius: CGFloat = 0) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: image)
        imageView.contentMode = contentMode
        imageView.clipsToBounds = clipsToBounds
        imageView.layer.cornerRadius = cornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func createImageView( contentMode: UIView.ContentMode = .scaleAspectFill, backgroundColor: UIColor = .lightGray, clipsToBounds: Bool = false, cornerRadius: CGFloat = 0) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = contentMode
        imageView.backgroundColor = backgroundColor
        imageView.clipsToBounds = clipsToBounds
        imageView.layer.cornerRadius = cornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func createBtnForMenuIcon(menu: UIMenu) -> UIButton {
        let btn = UIButton()
        btn.menu = menu
        btn.setImage(UIImage(named: "menuIcon"), for: .normal)
        btn.showsMenuAsPrimaryAction = true
        return btn
    }
    
    func createActivityIndicator() -> UIActivityIndicatorView {
        let act = UIActivityIndicatorView(style: .large)
        act.color = .gray
        act.hidesWhenStopped = true
        act.translatesAutoresizingMaskIntoConstraints = false
        return act
    }
    
    func createScrollView(frame: CGRect, indicator: Bool = false) -> UIScrollView {
        let scroll = UIScrollView(frame: frame)
        scroll.isScrollEnabled = true
        scroll.showsVerticalScrollIndicator = indicator
        scroll.translatesAutoresizingMaskIntoConstraints = true
        return scroll
    }
    
    func createView() -> UIView {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.backgroundColor = .white
        return uiView
    }
    
    func showLoadingIndicator(activityIndicator: UIActivityIndicatorView, collectionView: UICollectionView) {
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
            collectionView.isHidden = true
        }
    }
    
    func hideLoadingIndicator(activityIndicator: UIActivityIndicatorView, collectionView: UICollectionView) {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            collectionView.isHidden = false
        }
    }
    
    func setLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 500)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
   
    
    

    
    
    
}

