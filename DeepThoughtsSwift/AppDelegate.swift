//
//  AppDelegate.swift
//  DeepThoughtsSwift
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy var dataController: DataController = {
        let dc = DataController()
//        dc.networkController = NetworkController()
        dc.networkController = TestNetworkController()
        return dc
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        application.statusBarHidden = true

        if let navigationController = window?.rootViewController as? UINavigationController, vc = navigationController.topViewController as? MainViewController {
            vc.inject(self.dataController)
        } else {
            fatalError("Unexpected vc in window")
        }

        return true
    }
}
