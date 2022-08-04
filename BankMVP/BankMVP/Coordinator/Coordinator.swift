//
//  Coordinator.swift
//  BankMVP
//
//  Created by Felipe Melo on 17/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import UIKit

protocol Coordinator {
    var currentViewController: UIViewController? { get set }
    func start()
}
