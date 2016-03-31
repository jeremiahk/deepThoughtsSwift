//
//  SettingsTableViewManager.swift
//  DeepThoughtsSwift
//

import UIKit

class SettingsTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    
    convenience init(tableView: UITableView) {
        self.init()
        
        self.tableView = tableView
    }
    
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
        
        if indexPath.row == 8 {
            (cell as! SettingsTableViewCell).removeGray()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        test(tableView)
        return 88
    }
    
    func test(tableView: UITableView) {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = UIColor.blackColor()
        tableView.addSubview(topView)
        
        tableView.addConstraint(NSLayoutConstraint(item: topView, attribute: .Bottom, relatedBy: .Equal, toItem: tableView, attribute: .Top, multiplier: 1, constant: 0))
        tableView.addConstraint(NSLayoutConstraint(item: topView, attribute: .Width, relatedBy: .Equal, toItem: tableView, attribute: .Width, multiplier: 1, constant: 0))
        tableView.addConstraint(NSLayoutConstraint(item: topView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0, constant: 500))
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: tableView.frame)
        
        let blackView = UIView(frame: tableView.frame)
        blackView.backgroundColor = UIColor.blackColor()
        view.addSubview(blackView)
        
        return view
    }
}
