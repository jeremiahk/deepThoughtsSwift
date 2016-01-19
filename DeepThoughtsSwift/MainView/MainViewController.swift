//
//  MainViewController.swift
//  DeepThoughtsSwift
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var circleButton: CircleButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        circleButton.shrink()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        circleButton.animate()
    }
}
