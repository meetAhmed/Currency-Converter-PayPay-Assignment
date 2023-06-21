//
//  ConvertedCurrency.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 13/06/2023.
//

import Foundation

struct ConvertedCurrency: Hashable {
    let currencyFrom: String
    let currencyFromTitle: String
    let currencyTo: String
    let currencyToTitle: String
    let amountFrom: Double
    let amountTo: Double
}
