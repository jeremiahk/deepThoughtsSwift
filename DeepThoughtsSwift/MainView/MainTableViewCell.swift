//
//  MainTableViewCell.swift
//  DeepThoughtsSwift
//
//  Created by Jeremiah Kistler on 1/17/16.
//  Copyright © 2016 Jeremiah Kistler. All rights reserved.
//

import UIKit

extension MainTableViewCell: Updatable {
    typealias ViewData = MainTableViewCellData
}

struct MainTableViewCellData {
    let title: String
    let category: String
}

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    
    func updateWithViewData(viewData: ViewData) {
        titleLabel.text = viewData.title
        sectionLabel.text = viewData.category
    }
}
