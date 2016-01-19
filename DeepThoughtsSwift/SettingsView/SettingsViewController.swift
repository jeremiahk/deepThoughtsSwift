//
//  SettingsViewControllers.swift
//  DeepThoughtsSwift
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var circleButton: CircleButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        circleButton.shrink()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        circleButton.animate()
    }
    
    @IBAction func touchUpInside(sender: CircleButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}