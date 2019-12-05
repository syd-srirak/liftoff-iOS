//
//  Coordinator.swift
//  Liftoff
//
//  Created by Syd on 5/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import UIKit

class Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var navigationController: UINavigationController?

    init (navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
