//
//  StringProtocol+extensions.swift
//  BankMVP
//
//  Created by Felipe Melo on 17/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        return self[index(startIndex, offsetBy: offset)]
    }
}
