//
//  CoreTextTest.swift
//  DeepThoughtsSwift
//
//  Created by Jeremiah Kistler on 2/10/16.
//  Copyright © 2016 Jeremiah Kistler. All rights reserved.
//

import XCTest
@testable import DeepThoughtsSwift

class TextMaskTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatItInitialisesWithCAShapeLayer() {
        // Given
        let font = UIFont(name: "HelveticaNeue-Light", size: 17)
        let testString = NSAttributedString(string: "This is a good test", attributes: [NSFontAttributeName: font!])
        
        // When
        let tm = TextMask(fromAttributedString: testString)
        
        // That
        XCTAssertNotNil(tm.mask, "TextMask did not initialise with a CAShapeLayer")
    }
    
//    func testThatItReturnsTypeCAShapeLayer() {
//        // Given
//        let font = UIFont(name: "HelveticaNeue-Light", size: 17)
//        let testString = NSAttributedString(string: "This is a good test", attributes: [NSFontAttributeName: font!])
//        
//        let tm = TextMask(fromAttributedString: testString)
//        
//        // When
//        let mask = tm.generateMask()
//        
//        // That
//        XCTAssertNotNil(mask, "TestMask did not return the mask")
//    }
    
}