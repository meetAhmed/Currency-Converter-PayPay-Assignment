//
//  CurrencyRate.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 13/06/2023.
//

import Foundation

typealias CurrencyRateDictionary = [String: Double]

struct CurrencyRate: Decodable {
    let rates: CurrencyRateDictionary
}
