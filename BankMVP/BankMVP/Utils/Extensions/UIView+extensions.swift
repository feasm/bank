//
//  UIView+extensions.swift
//  BankMVP
//
//  Created by Felipe Melo on 17/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import UIKit

extension UIView {
    func setCorner(radius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
    }
}
