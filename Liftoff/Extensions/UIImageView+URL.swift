//
//  UIImageView+URL.swift
//  Liftoff
//
//  Created by Syd on 4/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL, completion: ((Bool) -> Void)?) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self, let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
                completion?(true)
            }
        }
    }
}
