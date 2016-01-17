//
//  MainTableViewManager.swift
//  DeepThoughtsSwift
//
//  Created by Jeremiah Kistler on 1/17/16.
//  Copyright © 2016 Jeremiah Kistler. All rights reserved.
//

import UIKit

class MainTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    let fakeData = FakeData()
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell") as! MainTableViewCell
        cell.sectionLabel.text = fakeData.categories[indexPath.row]
        cell.titleLabel.text = fakeData.titles[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeData.titles.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle2)
        let attributes = [NSFontAttributeName: font]
        let attributedString = NSAttributedString.init(string: self.fakeData.titles[indexPath.row], attributes: attributes)
        
        let height = attributedString.boundingRectWithSize(CGSize(width: 299, height: 1000), options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading, NSStringDrawingOptions.UsesDeviceMetrics], context: nil).height
        
        return height + 64.0;
    }
}
