//
//  SettingsTableViewCell.swift
//  DeepThoughtsSwift
//

import UIKit

extension SettingsTableViewCell: Updatable {
    typealias ViewData = SettingsTableViewCellData
}

struct SettingsTableViewCellData {
    let category: String
}

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    
    func updateWithViewData(viewData: SettingsTableViewCellData) {
        categoryLabel.text = viewData.category
    }
}
