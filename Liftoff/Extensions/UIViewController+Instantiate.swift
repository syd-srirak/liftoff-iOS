//
//  UIViewController+Instantiate.swift
//  Liftoff
//
//  Created by Syd on 4/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import UIKit

extension UIViewController {
    static let mainStoryboard = "Main"

    static var classIdentifier: String {
        return String(describing: Self.self)
    }

    static func instatiate() -> UIViewController {
        if #available(iOS 13.0, *) {
            return UIStoryboard(name: mainStoryboard, bundle: nil).instantiateViewController(identifier: classIdentifier)
        } else {
            return UIStoryboard(name: mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: classIdentifier)
        }
    }
}
