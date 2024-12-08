//
//  Components.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/7/24.
//

import UIKit

class Components {
    
    static func label(size: CGFloat = 14, weight: UIFont.Weight = .light, color: UIColor = .black, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = color
        label.textAlignment = textAlignment
        return label
    }
}

