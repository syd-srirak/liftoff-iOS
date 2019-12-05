//
//  SceneDelegate.swift
//  Liftoff
//
//  Created by Syd on 3/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var launchesCoordinator: LaunchesCoordinator!

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        launchesCoordinator = LaunchesCoordinator(navigationController: navigationController)
        launchesCoordinator.start()
        window?.makeKeyAndVisible()

        UINavigationBar.appearance().prefersLargeTitles = true

        guard let _ = (scene as? UIWindowScene) else { return }
    }
}
