//
//  MainTableViewCell.swift
//  DeepThoughtsSwift
//

import UIKit

extension MainTableViewCell: Updatable {
    typealias ViewData = MainTableViewCellData
}

struct MainTableViewCellData {
    let title: String
    let category: String
}

final class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    
    func updateWithViewData(viewData: ViewData) {
        titleLabel.text = viewData.title
        sectionLabel.text = viewData.category
    }
}
