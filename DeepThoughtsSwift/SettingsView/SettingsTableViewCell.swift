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
        let shapeLayer = CAShapeLayer()
        let testPath = UIBezierPath(rect: self.contentView.frame)
        
        let testFont = UIFont(name: "HelveticaNeue-Light", size: 15)
        let test = NSAttributedString(string: "This is a good test", attributes: [NSFontAttributeName: testFont!])
        let testPath2 = CGPathFromAttributedString(test)
        
        testPath.appendPath(testPath2)
        
        shapeLayer.path = testPath.CGPath
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        
        self.layer.mask = shapeLayer
    }
    
    private func CGPathFromAttributedString(string: NSAttributedString) -> UIBezierPath {
        // This is the final path you will return
        let letters = CGPathCreateMutable()
        
        // Create the line so we can pull out the Run
        let line = CTLineCreateWithAttributedString(string)
        
        // Returns a run array from the whole line.
        let runArray: [AnyObject] = CTLineGetGlyphRuns(line) as [AnyObject]
        
        // We only need the first run.
        let run: CTRun = runArray[0] as! CTRun
        
        // Get the font used in the string
        let attributes = CTRunGetAttributes(run) as Dictionary
        let font = attributes[kCTFontAttributeName] as! CTFont
        
        // Count the number of charicters in the run
        let glyphCount = CTRunGetGlyphCount(run) as Int
        
        // Loop through the run and get the size of each.
        for index in 0..<glyphCount {
            // Glyph with store that glyph
            var glyph = CGGlyph()
            
            // Positon store the position of the glyph
            var position = CGPoint()
            
            let range = CFRange(location: index, length: 1)
            
            CTRunGetGlyphs(run, range, &glyph)
            CTRunGetPositions(run, range, &position)
            
            let letter = CTFontCreatePathForGlyph(font, glyph, nil)
            
            var xPositionTransform = CGAffineTransformMakeTranslation(position.x, position.y)
            
            CGPathAddPath(letters, &xPositionTransform, letter)
        }
        // Flip the letters since coreText uses an alternate origin position
        var mirrorTransform = CGAffineTransformMakeScale(1, -1)
        let mirroredLetters = CGPathCreateCopyByTransformingPath(letters, &mirrorTransform)
        
        // Move the letters back down after fliping them
        let size = CGPathGetBoundingBox(mirroredLetters)
        var transform = CGAffineTransformMakeTranslation(0, size.height)
        let finalLetters = CGPathCreateCopyByTransformingPath(mirroredLetters, &transform)
        
        let path = UIBezierPath(CGPath: finalLetters!)
        return path
    }
}
