//
//  CoreText.swift
//  DeepThoughtsSwift
//
//  Created by Jeremiah Kistler on 2/10/16.
//  Copyright © 2016 Jeremiah Kistler. All rights reserved.
//

import UIKit

public class TextMask: NSObject {
    private var frame: CGRect!
    public var text: NSAttributedString! {
        didSet {
            generateMask()
        }
    }
    
    public private(set) var shapeLayer: CAShapeLayer!
    
    init(fromAttributedString text: NSAttributedString, AndFrame frame: CGRect) {
        self.text = text
        self.frame = frame
        
        super.init()
        
        generateMask()
    }

    private func generateMask() {
        let shapeLayer = CAShapeLayer()
        let finalPath = UIBezierPath(rect: frame)
        
        finalPath.appendPath(CGPathFromAttributedString(text))
        
        shapeLayer.path = finalPath.CGPath
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        
        self.shapeLayer = shapeLayer
    }
    
    private func CGPathFromAttributedString(text: NSAttributedString) -> UIBezierPath {
        // This is the final path you will return
        let letters = CGPathCreateMutable()

        // Create the line so we can pull out the Run
        let line = CTLineCreateWithAttributedString(text)

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
        
        return UIBezierPath(CGPath: finalLetters!)
    }
}
