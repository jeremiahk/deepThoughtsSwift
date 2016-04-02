//
//  AppDelegate.swift
//  DeepThoughtsSwift
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let dataController = DataController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        application.statusBarHidden = true

        guard let controller = window?.rootViewController as? MainViewController else {
            fatalError("Unexpected vc in window")
        }
        controller.dataController = dataController

        return true
    }
}
