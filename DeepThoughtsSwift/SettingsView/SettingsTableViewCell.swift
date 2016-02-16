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
    private var textMask: TextMask?
    func updateWithViewData(viewData: SettingsTableViewCellData) {
        addTextLayer(viewData.category)
    }
    
    func addTextLayer(text: String) {
        if let textMask = textMask {
            let testFont = UIFont(name: "HelveticaNeue-Light", size: 17)
            let test = NSAttributedString(string: text, attributes: [NSFontAttributeName: testFont!])
            textMask.text = test
            self.layer.mask = textMask.shapeLayer
        } else {
            let testFont = UIFont(name: "HelveticaNeue-Light", size: 17)
            let test = NSAttributedString(string: text, attributes: [NSFontAttributeName: testFont!])
            
            let offset = CGRect(x: 0.0, y: 0.0, width: 40, height: self.contentView.frame.height / 2)
            self.textMask = TextMask(fromAttributedString: test, WithFrame: self.contentView.frame, offset: offset)
            self.layer.mask = textMask!.shapeLayer
        }
    }
}