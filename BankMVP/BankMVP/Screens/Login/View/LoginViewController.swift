//
//  LoginViewController.swift
//  BankMVP
//
//  Created by Felipe Melo on 17/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import UIKit

protocol LoginViewControllerProtocol {
    func presentAlert(errorMessage: String)
}

final class LoginViewController: UIViewController, LoginViewControllerProtocol {

    // MARK: Outlets
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextFied: UITextField!
    
    // MARK: Properties
    
    private var presenter: LoginPresenterProtocol
    
    // MARK: Lifecycle
    
    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setup()
    }
    
    private func setup() {
        self.loginButton.setCorner(radius: 5)
    }

    // MARK: Methods
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextFied.text ?? ""
        
        if self.presenter.isValidForm(username: username, password: password) {
            self.presenter.login(username: username, password: password)
        } else {
            self.presentAlert(message: "Usuário ou senha inválidos!")
        }
    }

    func presentAlert(errorMessage: String) {
        self.presentAlert(message: errorMessage)
    }
}
