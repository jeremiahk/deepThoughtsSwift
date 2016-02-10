//
//  SettingsTableViewCell.swift
//  DeepThoughtsSwift
//

import UIKit

extension SettingsTableViewCell: Updatable {
    typealias ViewData = SettingsTableViewCellData
}

struct SettingsTableViewCellData {
    let category: String
}

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    
    func updateWithViewData(viewData: SettingsTableViewCellData) {
        categoryLabel.text = viewData.category
    }
    
    func addLayer() {
        let font = UIFont(name: "HelveticaNeue", size: 20)!
        
        var unichars = [UniChar]("OT".utf16)
        var glyphs = [CGGlyph](count: unichars.count, repeatedValue: 0)
        let gotGlyphs = CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
        if gotGlyphs {
            let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)!
            let path = UIBezierPath(CGPath: cgpath)
            
            let shapeLayer = CAShapeLayer()
            let testPath = UIBezierPath(rect: self.contentView.frame)
            testPath.appendPath(path)
            
            shapeLayer.path = testPath.CGPath
            shapeLayer.fillRule = kCAFillRuleEvenOdd
            
            self.layer.mask = shapeLayer
        }
    }
}
