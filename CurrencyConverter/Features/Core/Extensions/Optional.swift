//
//  Optional.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 10/06/2023.
//

import Foundation

extension Optional where Wrapped == String {
    var stringValue: String {
        if let self {
            return self
        }
        return ""
    }
}
