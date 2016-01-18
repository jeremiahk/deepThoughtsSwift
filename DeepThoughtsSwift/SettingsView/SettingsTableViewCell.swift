//
//  SettingsTableViewCell.swift
//  DeepThoughtsSwift
//
//  Created by Jeremiah Kistler on 1/17/16.
//  Copyright © 2016 Jeremiah Kistler. All rights reserved.
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
