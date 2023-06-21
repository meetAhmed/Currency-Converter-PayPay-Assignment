//
//  PreviewProvider.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 10/06/2023.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let sampleCountryFlag = URL(string: "https://flagcdn.com/56x42/ae.png")!
    
    let convertedCurrency: ConvertedCurrency = .init(
        currencyFrom: "AED",
        currencyFromTitle: "United Arab Emirates",
        currencyTo: "AFN",
        currencyToTitle: "Afghanistan",
        amountFrom: 10,
        amountTo: 230.61
    )
    
    let symbols: [String: String] = [
        "AED": "United Arab Emirates Dirham",
        "AFN": "Afghan Afghani",
        "ALL": "Albanian Lek",
        "AMD": "Armenian Dram",
        "ANG": "Netherlands Antillean Guilder",
        "AOA": "Angolan Kwanza",
        "ARS": "Argentine Peso",
        "AUD": "Australian Dollar",
        "AWG": "Aruban Florin",
        "AZN": "Azerbaijani Manat",
        "BAM": "Bosnia-Herzegovina Convertible Mark",
        "BBD": "Barbadian Dollar",
        "BDT": "Bangladeshi Taka",
        "BGN": "Bulgarian Lev",
        "BHD": "Bahraini Dinar",
        "BIF": "Burundian Franc"
    ]
}
