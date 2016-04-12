//
//  MainTableViewManager.swift
//  DeepThoughtsSwift
//

import UIKit

final class MainTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let cells: [CellConfiguratorType] = {
        var cells: [CellConfiguratorType] = []
        
        for thought in FakeData().thoughts {
            cells.append(CellConfigurator<MainTableViewCell>(viewData: MainTableViewCellData(title: thought.title, category: thought.category)))
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
        //TODO: This should not reinitialize the FakeData object. 
        let text = FakeData().thoughts[indexPath.row].title
        
        let font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle2)
        let attributes = [NSFontAttributeName: font]
        let attributedString = NSAttributedString.init(string: text, attributes: attributes)
        
        let width = tableView.frame.size.width - 80
        
        let height = attributedString.boundingRectWithSize(CGSize(width: width, height: 1000), options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading, NSStringDrawingOptions.UsesDeviceMetrics], context: nil).height
        
        return height + 64.0;
    }
}
