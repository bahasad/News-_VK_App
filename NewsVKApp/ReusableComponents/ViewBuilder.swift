//
//  ViewBuilder.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/13/24.
//

import UIKit
import Foundation



class ViewBuilder {
    
    
    func button(title: String,
                titleColor: UIColor = .systemBackground,
                backgroundColor: UIColor = .systemBackground,
                fontSize: CGFloat = 16,
                cornerRadius: CGFloat = 0.0,
                action: Selector? = nil,
                target: Any? = nil) -> UIButton
    {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        button.layer.cornerRadius = cornerRadius
        if let action = action, let target = target {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button 
    }
    
}

