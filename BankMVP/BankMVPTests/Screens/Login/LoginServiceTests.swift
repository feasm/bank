//
//  LoginServiceTests.swift
//  BankMVPTests
//
//  Created by Felipe Melo on 26/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import XCTest
@testable import BankMVP

class LoginServiceTests: XCTestCase {

    var service: LoginService!
    var session: SessionSpy!
    
    override func setUp() {
        session = SessionSpy()
        service = LoginService()
    }

    class SessionSpy: URLSession {
        var isLoginSuccess = true
        var dataTaskCalled = false
        var networkError = NetworkError.badURL
        
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            dataTaskCalled = true
            completionHandler(isLoginSuccess ? Data() : nil,
                              nil,
                              networkError)
            return URLSessionDataTask()
        }
        
    }

    func testLoginWithSuccess() {
        // Given
        let username = Mocks.username
        let password = Mocks.passwordValid
        var completionCalled = false
        
        let expectation = XCTestExpectation(description: "Logged in with success")

        
        // When
        service.login(endpoint: "Login", username: username, password: password) { (_) in
            completionCalled = true
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
        // Then
        XCTAssertTrue(completionCalled)
    }
    
    func testLoginWithBadURL() {
        // Given
        let username = Mocks.username
        let password = Mocks.passwordValid
        var completionCalled = false
        var hasBadUrlError = false
        service.baseUrl = ""
        
        let expectation = XCTestExpectation(description: "Logged in with error")
        
        // When
        service.login(endpoint: "", username: username, password: password) { result in
            completionCalled = true
            
            switch result {
            case .success(let _):
                break
            case .failure(let error):
                if case NetworkError.badURL = error {
                    hasBadUrlError = true
                }
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1000.0)
        
        // Then
        XCTAssertTrue(completionCalled)
        XCTAssertTrue(hasBadUrlError)
    }

}
