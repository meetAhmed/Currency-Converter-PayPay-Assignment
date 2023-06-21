//
//  LocalCache.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 09/06/2023.
//

import Foundation

// This is a protocol called 'CurrencyCache' that defines methods for caching currency symbols and rates.
protocol CurrencyCache {
    // Saves the currency symbols provided in the 'symbols' parameter.
    // The 'symbols' parameter is a dictionary with string keys and string values.
    func saveCurrencySymbols(_ symbols: Dictionary)
    
    // Retrieves the cached currency symbols as a dictionary.
    // The return value is a dictionary with string keys and string values.
    func getCurrencySymbols() -> Dictionary
    
    // Saves the currency rate provided in the 'rate' parameter.
    // The 'rate' parameter is a dictionary representing currency rates.
    func saveCurrencyRate(_ rate: CurrencyRateDictionary)
    
    // Retrieves the cached currency rate as a dictionary.
    // The return value is a dictionary representing currency rates.
    func getCurrencyRate() -> CurrencyRateDictionary
}
