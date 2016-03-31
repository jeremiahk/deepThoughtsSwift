//
//  MainViewController.swift
//  DeepThoughtsSwift
//

//import UIKit
import Quick
import Nimble

class MainVCSpec: QuickSpec {
    override func spec() {
        describe("Given a thing") {
            context("when doing an action") {
                context("with this data") {
//                    pending("then it should do this") {
                    it("Should do this") {
                        expect(1).to(equal(1))
                    }
                
                }
                
                context("with no data") {
//                    pending("then dont do anything") {
                    it("Should not do this") {
                        expect(1).notTo(equal(1))
                    }
                }
            }
        }
    }
}
