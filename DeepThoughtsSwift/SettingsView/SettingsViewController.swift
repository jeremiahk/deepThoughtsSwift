//
//  SettingsViewControllers.swift
//  DeepThoughtsSwift
//
//  Created by Jeremiah Kistler on 1/17/16.
//  Copyright © 2016 Jeremiah Kistler. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var circleButton: CircleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
    }
}