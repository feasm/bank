//
//  LoginViewModelTests.swift
//  BankMVPTests
//
//  Created by Felipe Melo on 26/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import XCTest
@testable import BankMVP

class LoginPresenterTests: XCTestCase {

    var presenter: LoginPresenter!
    var viewController: LoginViewControllerSpy!
    var coordinator: LoginCoordinatorSpy!
    var service: LoginServiceSpy!
    
    override func setUp() {
        coordinator = LoginCoordinatorSpy()
        service = LoginServiceSpy()
        viewController = LoginViewControllerSpy()
        presenter = LoginPresenter(coordinator: coordinator, service: service)
        presenter.viewController = viewController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class LoginViewControllerSpy: LoginViewControllerProtocol {
        var presentAlertCalled = false
        
        var errorMessage = ""
        
        func presentAlert(errorMessage: String) {
            presentAlertCalled = true
            self.errorMessage = errorMessage
        }
    }
    
    class LoginCoordinatorSpy: LoginCoordinatorProtocol {
        var navigateToHomeCalled = false
        var loginModel: LoginModel? = nil
        
        func navigateToHome(loginModel: LoginModel) {
            navigateToHomeCalled = true
            self.loginModel = loginModel
        }
    }
    
    class LoginServiceSpy: LoginServiceProtocol {
        var isLoginSuccess = true
        
        var loginCalled = false
        var username = ""
        var password = ""
        
        func login(endpoint: String, username: String, password: String, _ completion: @escaping LoginCompletion) {
            loginCalled = true
            self.username = username
            self.password = password
            
            if isLoginSuccess {
                completion(.success(Mocks.loginModel))
            } else {
                completion(.failure(Mocks.errorMock))
            }
        }
    }

    func testLoginWithSuccess() {
        // Given
        let username = Mocks.username
        let password = Mocks.passwordValid
        
        // When
        presenter.login(username: username, password: password)
        
        // Then
        XCTAssertTrue(service.loginCalled)
        XCTAssertEqual(username, service.username)
        XCTAssertEqual(password, service.password)
        
        XCTAssertTrue(coordinator.navigateToHomeCalled)
        XCTAssertNotNil(coordinator.loginModel)
        XCTAssertEqual(coordinator.loginModel?.customerName, Mocks.loginModel.customerName)
        XCTAssertEqual(coordinator.loginModel?.accountNumber, Mocks.loginModel.accountNumber)
        XCTAssertEqual(coordinator.loginModel?.branchNumber, Mocks.loginModel.branchNumber)
        XCTAssertEqual(coordinator.loginModel?.checkingAccountBalance, Mocks.loginModel.checkingAccountBalance)
        XCTAssertEqual(coordinator.loginModel?.id, Mocks.loginModel.id)
    }
    
    func testLoginWithError() {
        // Given
        let username = Mocks.username
        let password = Mocks.passwordValid
        service.isLoginSuccess = false
        
        // When
        presenter.login(username: username, password: password)
        
        // Then
        XCTAssertTrue(service.loginCalled)
        XCTAssertEqual(username, service.username)
        XCTAssertEqual(password, service.password)
        
        XCTAssertFalse(coordinator.navigateToHomeCalled)
        
        XCTAssertTrue(viewController.presentAlertCalled)
        XCTAssertEqual(viewController.errorMessage, "The operation couldn’t be completed. (BankMVP.NetworkError error 2.)")
    }
    
    func testValidPassword() {
        // Given
        let username = Mocks.username
        let password = Mocks.passwordValid
        
        // When
        let isValid = presenter.isValidForm(username: username, password: password)
        
        // Then
        XCTAssertTrue(isValid)
    }
    
    func testPasswordNoNumber() {
        // Given
        let username = Mocks.username
        let password = Mocks.passwordNoNumber
        
        // When
        let isValid = presenter.isValidForm(username: username, password: password)
        
        // Then
        XCTAssertFalse(isValid)
    }
    
    func testPasswordNoSpecialCharacter() {
        // Given
        let username = Mocks.username
        let password = Mocks.passwordNoSpecialCharacter
        
        // When
        let isValid = presenter.isValidForm(username: username, password: password)
        
        // Then
        XCTAssertFalse(isValid)
    }
    
    func testPasswordNoUppercasedLetter() {
        // Given
        let username = Mocks.username
        let password = Mocks.passwordNoUppercasedLetter
        
        // When
        let isValid = presenter.isValidForm(username: username, password: password)
        
        // Then
        XCTAssertFalse(isValid)
    }

}
