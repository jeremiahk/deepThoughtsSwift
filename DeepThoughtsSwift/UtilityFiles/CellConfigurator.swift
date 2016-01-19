//
//  CellConfigurator.swift
//  DeepThoughtsSwift
//

import UIKit

protocol Updatable: class {
    typealias ViewData
    
    func updateWithViewData(viewData: ViewData)
}

struct CellConfigurator<Cell where Cell: Updatable, Cell: UITableViewCell> {
    let viewData: Cell.ViewData
    let reuseIdentifier: String = NSStringFromClass(Cell)
    let cellClass: AnyClass = Cell.self
    
    func updateCell(cell: UITableViewCell) {
        if let cell = cell as? Cell {
            cell.updateWithViewData(viewData)
        }
    }
}

protocol CellConfiguratorType {
    var reuseIdentifier: String { get }
    var cellClass: AnyClass { get }
    
    func updateCell(cell: UITableViewCell)
}

extension CellConfigurator: CellConfiguratorType {}
