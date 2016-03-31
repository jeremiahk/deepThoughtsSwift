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
    
    var greyView: UIView?
    var blackView: UIView?
    
    func updateWithViewData(viewData: SettingsTableViewCellData) {
        if greyView == nil {
            greyView = UIView(frame: self.contentView.frame)
            greyView?.backgroundColor = UIColor.grayColor()
            self.addSubview(greyView!)
        }
        
        if blackView == nil {
            blackView = UIView(frame: self.contentView.frame)
            blackView?.backgroundColor = UIColor.blackColor()
            self.addSubview(blackView!)
        }

        addTextLayer(viewData.category)
    }
    
    func addTextLayer(text: String) {
        if let textMask = textMask {
            let testFont = UIFont(name: "HelveticaNeue", size: 18)
            let test = NSAttributedString(string: text, attributes: [NSFontAttributeName: testFont!])
            textMask.text = test
            blackView!.layer.mask = textMask.shapeLayer
        } else {
            let testFont = UIFont(name: "HelveticaNeue", size: 18)
            let test = NSAttributedString(string: text, attributes: [NSFontAttributeName: testFont!])
            
            let offset = CGRect(x: 0.0, y: 0.0, width: 40, height: self.contentView.frame.height / 2)
            self.textMask = TextMask(fromAttributedString: test, WithFrame: self.contentView.frame, offset: offset)
            blackView!.layer.mask = textMask!.shapeLayer
        }
    }
    
    func removeGray() {
        greyView?.alpha = 0
    }
}