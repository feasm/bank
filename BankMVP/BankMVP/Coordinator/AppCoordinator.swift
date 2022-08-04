//
//  AppCoordinator.swift
//  BankMVP
//
//  Created by Felipe Melo on 17/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    let window: UIWindow?
    var currentViewController: UIViewController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let service = LoginService()
        let loginPresenter = LoginPresenter(coordinator: self, service: service)
        let loginViewController = LoginViewController(presenter: loginPresenter)
        loginPresenter.viewController = loginViewController
        
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
        
        currentViewController = loginViewController
    }
}

extension AppCoordinator: LoginCoordinatorProtocol {
    func navigateToHome(loginModel: LoginModel) {
        let homeViewController = UIViewController()
        homeViewController.view.backgroundColor = .blue
        currentViewController?.present(homeViewController, animated: true, completion: { [weak self] in
            self?.currentViewController = homeViewController
        })
    }
}
