//
//  CountryFlagHelper.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 10/06/2023.
//

import Foundation

// This is a singleton class called CountryFlagHelper.
// It provides a shared instance of CountryFlagHelper that can be accessed globally.
class CountryFlagHelper {
    static let instance = CountryFlagHelper()
    private var countryInfo: [CountryInfo] = []
    
    private init() {
        loadCountryData()
    }
}

extension CountryFlagHelper {
    // This function returns the URL of a country flag image based on a given currency name.
    func getCountryFlagUrl(currencyName: String) -> URL? {
        // Find the index of the first country whose name matches the given currency name.
        if let index = countryInfo.firstIndex(where: { currencyName.trim().contains($0.name.trim()) }) {
            let code = countryInfo[index].code.lowercased().trim()
            // Generate the URL for the country flag image using the country's code and return it as a URL object.
            return URL(string: "https://flagcdn.com/56x42/\(code).png")
        }
        // Return nil if no matching country is found.
        return nil
    }
}

private extension CountryFlagHelper {
    // This function uses the NSLocale class to retrieve ISO country codes and other country information.
    // For each country code, it creates a CountryInfo object containing the country name and code, and adds it to the 'countryInfo' array.
    func loadCountryData() {
        countryInfo = NSLocale.isoCountryCodes.map { code in
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let currentLocaleID = NSLocale.current.identifier
            let name = NSLocale(localeIdentifier: currentLocaleID).displayName(forKey: NSLocale.Key.identifier, value: id).stringValue
            return CountryInfo(name: name, code: code )
        }
    }
}
