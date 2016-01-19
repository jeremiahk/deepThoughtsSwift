//
//  CircleButton.swift
//  DeepThoughtsSwift
//

import UIKit

public class CircleButton: UIButton {
    public var buttonColor: UIColor!
    
    public var backgroundSize: CGRect {
        get {
            let offset = self.frame.size.height * 0.3
            return CGRect(x: self.frame.origin.x + offset, y: self.frame.origin.y + offset, width: self.frame.size.width * 0.4, height: self.frame.size.height * 0.4)
        }
    }
    
    override public func drawRect(rect: CGRect) {
        let center = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
        
        let path = UIBezierPath(arcCenter: center, radius: rect.size.width * 0.15, startAngle: 0.0, endAngle: 6.28319, clockwise: true)
        
        self.buttonColor?.setFill()
        path.fill()
    }
    
    public func shrink() {
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0)
    }
    
    public func animate() {
        UIView.animateWithDuration(0.2, animations: {
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.25, 1.25)
        }, completion: { _ in
            
            UIView.animateWithDuration(0.2, animations: {
                self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95)
            }, completion: { _ in
                
                UIView.animateWithDuration(0.25, animations: {
                    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
                })
            })
        })
    }
}