//
//  UIColor.swift
//  DeepThoughtsSwift
//

import UIKit

extension UIColor {
    func rgb(r: CGFloat, b: CGFloat, g: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: b/255, blue: b/255, alpha: 1.0)
    }

    func rgba(r: CGFloat, b: CGFloat, g: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: b/255, blue: b/255, alpha: a)
    }
}