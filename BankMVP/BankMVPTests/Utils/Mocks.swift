//
//  Mocks.swift
//  BankMVPTests
//
//  Created by Felipe Melo on 26/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import Foundation
@testable import BankMVP

struct Mocks {
    static let username = "02053516119"
    static let passwordValid = "Teste@1"
    static let passwordNoNumber = "Teste@"
    static let passwordNoSpecialCharacter = "Teste1"
    static let passwordNoUppercasedLetter = "teste@1"
    static let loginModel = LoginModel(customerName: "Age",                                      accountNumber: "1",                                       branchNumber: "2",                                        checkingAccountBalance: 10,
                                       id: "3")
    static let errorMock = NetworkError.badURL
}
