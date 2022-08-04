//
//  String+extensions.swift
//  BankMVP
//
//  Created by Felipe Melo on 17/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        return self.contains("@")
    }
    
    func isValidCpf() -> Bool {
        if self.count != 11 {
            return false
        }
        
        var cpfIndex = 0
        var cpfNumberSum = 0
        for number in (2...10).reversed() {
            if let cpfDigit = self[cpfIndex].wholeNumberValue {
                cpfNumberSum += cpfDigit * number
                cpfIndex += 1
            }
        }
        
        let cpfVerificationDigit = (cpfNumberSum * 10) % 11
        
        return cpfVerificationDigit == self[9].wholeNumberValue
    }
    
    func isValidPassword() -> Bool {
        // o campo password deve validar se a senha tem pelo menos uma letra maiuscula, um caracter especial e um caracter alfanumérico.
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: self) else { return false }
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard texttest1.evaluate(with: self) else { return false }
        
        let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        guard texttest2.evaluate(with: self) else { return false }
        
        return true
    }
}
