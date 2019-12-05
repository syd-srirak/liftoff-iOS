//
//  UIView+Identifier.swift
//  Liftoff
//
//  Created by Syd on 5/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import UIKit

extension UIView {
    static var classIdentifier: String {
        return String(describing: Self.self)
    }
}
