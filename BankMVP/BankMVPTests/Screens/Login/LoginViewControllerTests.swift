//
//  LoginViewControllerTests.swift
//  BankMVPTests
//
//  Created by Felipe Melo on 26/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import XCTest
@testable import BankMVP

class LoginViewControllerTests: XCTestCase {
    
    var window: UIWindow!
    var viewController: LoginViewController!
    var presenter: LoginPresenterSpy!

    override func setUp() {
        window = UIWindow()
        presenter = LoginPresenterSpy()
        viewController = LoginViewController(presenter: presenter)
        
        loadView()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func loadView() {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
    
    class LoginPresenterSpy: LoginPresenterProtocol {
        var loginCalled = false
        var isValidFormCalled = false
        var isValidFormTrue = true
        
        var username = ""
        var password = ""
        
        func login(username: String, password: String) {
            loginCalled = true
        }
        
        func isValidForm(username: String, password: String) -> Bool {
            isValidFormCalled = true
            self.username = username
            self.password = password
            
            return isValidFormTrue
        }
    }

    func testLoginButtonPressedWithSuccess() {
        // Given
        let username = Mocks.username
        let password = Mocks.passwordValid
        viewController.usernameTextField.text = username
        viewController.passwordTextFied.text = password
        
        // When
        viewController.loginButtonPressed(UIButton())
        
        // Then
        XCTAssertTrue(presenter.isValidFormCalled)
        
        XCTAssertEqual(presenter.username, username)
        XCTAssertEqual(presenter.password, password)
        
        XCTAssertTrue(presenter.loginCalled)
    }
    
    func testLoginButtonPressedWithInvalidForm() {
        // Given
        let username = Mocks.username
        let password = Mocks.passwordValid
        viewController.usernameTextField.text = username
        viewController.passwordTextFied.text = password
        presenter.isValidFormTrue = false
        
        // When
        viewController.loginButtonPressed(UIButton())
        
        // Then
        XCTAssertTrue(presenter.isValidFormCalled)
        
        XCTAssertEqual(presenter.username, username)
        XCTAssertEqual(presenter.password, password)
        
        XCTAssertFalse(presenter.loginCalled)
    }

}
