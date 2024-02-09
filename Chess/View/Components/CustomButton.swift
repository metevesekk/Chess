//
//  CustomButton.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import UIKit

class CustomButton: UIView {
    
    static func setupButton(_ button: UIButton, backgroundColor: UIColor, tintColor: UIColor, textColor: UIColor, fontSize: CGFloat, fontName: String, title: String, cornerRadius: CGFloat, bordorColor: CGColor? = nil, borderWidth: CGFloat? = nil){
        button.isEnabled = true
        button.isHidden = false
        button.backgroundColor = backgroundColor
        button.tintColor = tintColor
        button.titleLabel?.font = UIFont(name: fontName, size: fontSize)
        button.titleLabel?.textColor = textColor
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = cornerRadius
        if let bordorColor = bordorColor{
            button.layer.borderColor = bordorColor
        }
        if let borderWidth = borderWidth{
            button.layer.borderWidth = borderWidth
        }
    }
}
