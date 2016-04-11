//
//  SettingsViewControllers.swift
//  DeepThoughtsSwift
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var circleButton: CircleButton!

    var dataController: DataController!
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        
        let color1 = UIColor.rgb(133, g: 225, b: 115).CGColor as CGColorRef
        let color2 = UIColor.rgb(232, g: 168, b: 42).CGColor as CGColorRef
        let color3 = UIColor.rgb(225, g: 0, b: 0).CGColor as CGColorRef
        let color4 = UIColor.rgb(36, g: 12, b: 232).CGColor as CGColorRef
        let color5 = UIColor.rgb(13, g: 225, b: 182).CGColor as CGColorRef
        
        gradient.colors = [color1, color2, color3, color4, color5]
        gradient.locations = [0.0, 0.24, 0.5, 0.75, 1.0]
        
        return gradient
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assertDependencies()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        circleButton.shrink()

        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        circleButton.animate()
    }
    
    @IBAction func touchUpInside(sender: CircleButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension SettingsViewController: hasCircleButton {
    func getCircleButton() -> CircleButton {
        return circleButton
    }
}

extension SettingsViewController: Injectable {
    typealias T = DataController
    
    func inject(dataController: T) {
        self.dataController = dataController
    }
    
    func assertDependencies() {
        assert(self.dataController != nil)
    }
}