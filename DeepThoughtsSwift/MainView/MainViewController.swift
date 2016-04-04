//
//  MainViewController.swift
//  DeepThoughtsSwift
//

import UIKit
import CoreData

protocol hasCircleButton {
    func getCircleButton() -> CircleButton
}

class MainViewController: UIViewController, hasCircleButton {
    @IBOutlet weak var circleButton: CircleButton!
    @IBOutlet weak var tableView: UITableView!

    var dataController: DataController?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        circleButton.shrink()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        circleButton.animate()
    }
    
    func getCircleButton() -> CircleButton {
        return circleButton
    }
}
