//
//  LaunchDetailCoordinator.swift
//  Liftoff
//
//  Created by Syd on 5/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import SafariServices

class LaunchDetailCoordinator: Coordinator {
    func start(with missionName: String, flightNumber: Int, rocketId: String) {
        guard let launchDetailViewController = LaunchDetailViewController.instatiate() as? LaunchDetailViewController else { return }
        launchDetailViewController.title = missionName
        launchDetailViewController.viewModel = LaunchDetailViewModel(flightNumber: flightNumber, rocketId: rocketId)
        launchDetailViewController.delegate = self
        navigationController?.pushViewController(launchDetailViewController, animated: true)
    }
}

extension LaunchDetailCoordinator: LaunchDetailNavigationDelegate {
    func presentRocketInformation(url: URL) {
        navigationController?.present(SFSafariViewController(url: url), animated: true)
    }
}
