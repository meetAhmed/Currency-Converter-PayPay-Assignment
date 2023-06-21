//
//  Double.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 13/06/2023.
//

import Foundation

extension Double {
    func formatAmount() -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.currencyCode = ""
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let num = NSNumber(value: self)
        return formatter.string(from: num) ?? "0.00"
    }
}
