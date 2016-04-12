//
//  TestNetworkController.swift
//  DeepThoughtsSwift
//
//  Created by Jeremiah Kistler on 4/10/16.
//  Copyright © 2016 Jeremiah Kistler. All rights reserved.
//

import Foundation

final class TestNetworkController: NSObject, NetworkProtocol {
    private lazy var testData: [[String: AnyObject]] = self.getTestData()!
    
    private func getTestData() -> [[String: AnyObject]]? {
        guard let dataPath = NSBundle.mainBundle().pathForResource("fakeData", ofType: "json") else {
            fatalError("Could not find fakeData file")
        }
        guard let rawData = NSData(contentsOfFile: dataPath) else {
            fatalError("Could not create NSData from fakeData file.")
        }
        
        do {
            guard let json = try NSJSONSerialization.JSONObjectWithData(rawData, options: .AllowFragments) as? [[String: AnyObject]] else {
                fatalError("Could not cast fake json")
            }
            
            return json
        } catch {
            print("Error creating test json: \(error)")
        }
        
        return nil
    }

    func getAllThoughts(closure: [String : AnyObject] -> ()) {
        
    }
    
    func getAllCategories(closure: [String: AnyObject] -> ()) {
        let titles = testData.flatMap(){ $0["title"] }
        let finalData = ["categories": titles.description]
        closure(finalData)
    }
}