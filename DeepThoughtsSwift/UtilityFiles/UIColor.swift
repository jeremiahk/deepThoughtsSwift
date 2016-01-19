//
//  UIColor.swift
//  DeepThoughtsSwift
//

import UIKit

extension UIColor {
    func rbg(r: CGFloat, b: CGFloat, g: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: b/255, blue: b/255, alpha: 1.0)
    }

    func rbga(r: CGFloat, b: CGFloat, g: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: b/255, blue: b/255, alpha: a)
    }
}