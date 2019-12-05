//
//  AppDelegate.swift
//  Liftoff
//
//  Created by Syd on 3/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var launchesCoordinator: LaunchesCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        launchesCoordinator = LaunchesCoordinator(navigationController: navigationController)
        launchesCoordinator.start()
        window?.makeKeyAndVisible()

        UINavigationBar.appearance().prefersLargeTitles = true

        return true
    }
}
