//
//  BookmarkButton.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/8/24.
//


import UIKit

final class BookmarkButton: UIButton {
    
  
    var isBookmarked: Bool = false {
        didSet {
            UIView.transition(with: self, duration: 0.15, options: [.transitionCrossDissolve, .curveEaseOut]) {
                let image = self.isBookmarked ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
                self.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
            }
        }
    }
    
    init(tintColor: UIColor = .black, isBookmarked: Bool = false) {
        self.isBookmarked = isBookmarked
        super.init(frame: .zero)
        let initialImage = isBookmarked ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        setImage(initialImage?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.tintColor = tintColor
        
      
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func configureButton() {
        layer.cornerRadius = 12
        clipsToBounds = true
    }
}
