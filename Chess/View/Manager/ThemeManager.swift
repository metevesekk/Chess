//
//  ThemeManager.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import UIKit

struct ThemeManager{
    
    static func colorCode(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var cleanedHexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cleanedHexString.hasPrefix("#") {
            cleanedHexString.remove(at: cleanedHexString.startIndex)
        }

        if cleanedHexString.count != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cleanedHexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
