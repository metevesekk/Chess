//
//  CustomLabel.swift
//  Chess
//
//  Created by Mete Vesek on 9.02.2024.
//

import UIKit

class CustomLabel: UIView {

    static func setupLabel(_ label: UILabel, backgroundColor: UIColor? = nil, tintColor: UIColor, textColor: UIColor, fontSize: CGFloat, fontName: String, text: String, cornerRadius: CGFloat, bordorColor: CGColor? = nil, borderWidth: CGFloat? = nil){
        label.isEnabled = true
        label.isHidden = false
        label.tintColor = tintColor
        label.font = UIFont(name: fontName, size: fontSize)
        label.text = text
        label.textColor = textColor
        label.layer.cornerRadius = cornerRadius
        
        if let backgroundColor = backgroundColor{
            label.backgroundColor = backgroundColor
        }
        
        if let bordorColor = bordorColor{
            label.layer.borderColor = bordorColor
        }
        if let borderWidth = borderWidth{
            label.layer.borderWidth = borderWidth
        }
    }
}
