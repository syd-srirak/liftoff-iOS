//
//  LaunchesCoordinator.swift
//  Liftoff
//
//  Created by Syd on 5/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import UIKit

class LaunchesCoordinator: Coordinator {
    private lazy var launchDetailCoordinator = LaunchDetailCoordinator(navigationController: navigationController)

    func start() {
        guard let launchesViewController = LaunchesViewController.instatiate() as? LaunchesViewController else { return }
        launchesViewController.viewModel = LaunchesViewModel()
        launchesViewController.delegate = self
        navigationController?.pushViewController(launchesViewController, animated: false)
    }
}

extension LaunchesCoordinator: LaunchesNavigationDelegate {
    func navigateToLaunchDetails(missionName: String, flightNumber: Int, rocketId: String) {
        launchDetailCoordinator.start(with: missionName, flightNumber: flightNumber, rocketId: rocketId)
    }
}
