//
//  AppColors.swift
//  WeatherApp
//
//  Created by Maksym on 21/01/2022.
//

import UIKit


public extension UIColor {
    static let appWhite = UIColor(hexString: "#FFFFFF")
    static let appGray = UIColor(hexString: "#8E8E93")
    static let appBlack = UIColor(hexString: "#000000")
    static let appBlue = UIColor(hexString: "#0096FF")
    static let appPurple = UIColor(hexString: "#9437FF")
    static let appRed = UIColor(hexString: "#FF3B30")
}

public extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
