//
//  SettingsTableViewManager.swift
//  DeepThoughtsSwift
//
//  Created by Jeremiah Kistler on 1/17/16.
//  Copyright © 2016 Jeremiah Kistler. All rights reserved.
//

import UIKit

class SettingsTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    let fakeData = FakeData()
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell") as! SettingsTableViewCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeData.titles.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
}
