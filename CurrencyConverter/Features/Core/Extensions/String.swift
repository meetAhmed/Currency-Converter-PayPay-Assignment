//
//  String.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 10/06/2023.
//

import Foundation

extension String {
    func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var asNSString: NSString {
        NSString(string: self.trim())
    }
    
    var asDouble: Double {
        Double(self.trim()) ?? 0.0
    }
}
