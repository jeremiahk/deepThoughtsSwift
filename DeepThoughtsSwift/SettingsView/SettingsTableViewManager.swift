//
//  SettingsTableViewManager.swift
//  DeepThoughtsSwift
//
//  Created by Jeremiah Kistler on 1/17/16.
//  Copyright © 2016 Jeremiah Kistler. All rights reserved.
//

import UIKit

class SettingsTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    private let cells: [CellConfiguratorType] = {
        var cells: [CellConfiguratorType] = []
        
        for thought in FakeData().thoughts {
            cells.append(CellConfigurator<SettingsTableViewCell>(viewData: SettingsTableViewCellData(category: thought.category)))
        }
        
        return cells
    }()
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellConfigurator = cells[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellConfigurator.reuseIdentifier, forIndexPath: indexPath)
        cellConfigurator.updateCell(cell)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
}
