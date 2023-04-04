//
//  Text+.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 2.04.2023.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func secureText() -> String {
        var arr = Array(self)
        
        var secureText: String = ""
                
        for _ in 0...arr.count {
            secureText += "●"
        }
        
        return secureText
    }
}
