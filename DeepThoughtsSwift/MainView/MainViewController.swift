//
//  MainViewController.swift
//  DeepThoughtsSwift
//

import UIKit
import CoreData

// TODO: Move all these protocol declarations into seperate file.
protocol hasCircleButton {
    func getCircleButton() -> CircleButton
}

protocol Injectable {
    associatedtype T
    func inject(_: T)
    func assertDependencies()
}

protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier, segueIdentifier = SegueIdentifier(rawValue: identifier) else {
            fatalError("Invalid segue identifier \(segue.identifier).")
        }
        
        return segueIdentifier
    }
}







class MainViewController: UIViewController, SegueHandlerType {
    @IBOutlet weak var circleButton: CircleButton!
    @IBOutlet weak var tableView: UITableView!

    var dataController: DataController!

    enum SegueIdentifier: String {
        case circleSegue
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        assertDependencies()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        circleButton.shrink()
        
        //TODO: Move this into viewModel object
        dataController.getAllThoughts() {data in
            print("data is data")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        circleButton.animate()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segueIdentifierForSegue(segue) {
        case .circleSegue :
            let settingsVC = segue.destinationViewController as? SettingsViewController
            settingsVC?.inject(dataController)
        }
    }
}

extension MainViewController: hasCircleButton {
    func getCircleButton() -> CircleButton {
        return circleButton
    }
}

extension MainViewController: Injectable {
    typealias T = DataController

    func inject(dataController: T) {
        self.dataController = dataController
    }

    func assertDependencies() {
        assert(self.dataController != nil)
    }
}
