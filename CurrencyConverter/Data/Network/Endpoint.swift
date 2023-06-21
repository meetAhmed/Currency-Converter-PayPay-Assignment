//
//  Endpoint.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 09/06/2023.
//

import Foundation

/**
 This is an enumeration called 'Endpoint' that represents different types of API endpoints.
 
 It defines two cases:
 - 'currencySymbols': Represents an API endpoint for retrieving currency symbols.
 - 'currencyRates': Represents an API endpoint for retrieving currency rates.
 
 This enumeration can be used to specify the type of endpoint for constructing API requests.
 */
enum Endpoint {
    case currencySymbols
    case currencyRates
}

extension Endpoint {
    var fullPath: String {
        Constants.baseURL + path
    }
    
    var method: String {
        httpMethod.rawValue.uppercased()
    }
}

private extension Endpoint {
    var path: String {
        switch self {
        case .currencySymbols:
            return "/api/currencies.json"
        case .currencyRates:
            return "/api/latest.json"
        }
    }
    
    var httpMethod: HTTPMethodType {
        switch self {
        case .currencySymbols:
            return .get
        case .currencyRates:
            return .get
        }
    }
}
