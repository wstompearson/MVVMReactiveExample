//
//  AppDelegate.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 23/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let splitViewController = window!.rootViewController as! UISplitViewController
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.delegate = self
        coordinator = Coordinator(splitViewController)
        
        Store.shared.initialise(errorHandler: { [unowned self] error in
            self.coordinator?.presentErrorAlert(error)
        })
        
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
