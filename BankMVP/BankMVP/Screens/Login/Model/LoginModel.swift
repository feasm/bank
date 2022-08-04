//
//  LoginModel.swift
//  BankMVP
//
//  Created by Felipe Melo on 17/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import Foundation

struct LoginModel: Decodable {
    let customerName: String?
    let accountNumber: String?
    let branchNumber: String?
    let checkingAccountBalance: Double?
    let id: String?
}
