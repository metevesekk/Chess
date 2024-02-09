//
//  LayoutManager.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import UIKit

struct LayoutManager{
    
    static func anchor(childView: UIView,  parentView: UIView, top: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat = 0,
                       leading: NSLayoutXAxisAnchor? = nil, paddingLeading: CGFloat = 0,
                       bottom: NSLayoutYAxisAnchor? = nil, paddingBottom: CGFloat = 0,
                       trailing: NSLayoutXAxisAnchor? = nil, paddingTrailing: CGFloat = 0,
                       width: CGFloat? = nil, heigth: CGFloat? = nil,
                       centerX: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil, paddingCenterX: CGFloat = 0,
                       centerY: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, paddingCenterY: CGFloat = 0){
        
        parentView.addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            childView.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            childView.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        if let bottom = bottom {
            childView.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let trailing = trailing {
            childView.trailingAnchor.constraint(equalTo: trailing, constant: paddingTrailing).isActive = true
        }
        
        if let width = width{
            childView.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = heigth{
            childView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let centerX = centerX{
            childView.centerXAnchor.constraint(equalTo: centerX, constant: paddingCenterX).isActive = true
        }
        
        if let centerY = centerY{
            childView.centerYAnchor.constraint(equalTo: centerY, constant: paddingCenterY).isActive = true
        }
    }
}

