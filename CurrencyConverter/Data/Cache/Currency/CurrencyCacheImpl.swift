//
//  LocalCacheImpl.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 09/06/2023.
//

import Foundation

class CurrencyCacheImpl: CurrencyCache {
    private init() {}
    
    static let instance = CurrencyCacheImpl()
    
    // Saves the currency symbols provided in the 'symbols' parameter.
    // The 'symbols' parameter is a dictionary with string keys and string values.
    func saveCurrencySymbols(_ symbols: Dictionary) {
        UserDefaults.standard.set(symbols, forKey: Constants.currencySymbols)
    }
    
    // Retrieves the cached currency symbols as a dictionary.
    // The return value is a dictionary with string keys and string values.
    func getCurrencySymbols() -> Dictionary {
        UserDefaults.standard.object(forKey: Constants.currencySymbols) as? Dictionary ?? [:]
    }
    
    // Saves the currency rate provided in the 'rate' parameter.
    // The 'rate' parameter is a dictionary representing currency rates.
    func saveCurrencyRate(_ rate: CurrencyRateDictionary) {
        UserDefaults.standard.set(rate, forKey: Constants.currencyRates)
    }
    
    // Retrieves the cached currency rate as a dictionary.
    // The return value is a dictionary representing currency rates.
    func getCurrencyRate() -> CurrencyRateDictionary {
        UserDefaults.standard.object(forKey: Constants.currencyRates) as? CurrencyRateDictionary ?? [:]
    }
}
