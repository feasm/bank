//
//  UIViewController+extensions.swift
//  BankMVP
//
//  Created by Felipe Melo on 17/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Erro de formulário", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
}
