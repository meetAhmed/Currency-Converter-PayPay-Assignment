//
//  APIConstructor.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 09/06/2023.
//

import Foundation

typealias Dictionary = [String: String]

/**
 The struct 'APIConstructor' is defined with the following properties:
 - 'endpoint': An instance of the 'Endpoint' struct representing the endpoint information.
 - 'queryParams': A dictionary representing the query parameters for the API request. It is initialized as an empty dictionary.
 - 'bodyParams': A dictionary representing the body parameters for the API request. It is initialized as an empty dictionary.
 
 This struct can be used to construct API requests by providing the endpoint, query parameters, and body parameters.
 The 'queryParams' and 'bodyParams' properties can be modified as needed before making the API request.
 */
struct APIConstructor {
    let endpoint: Endpoint
    var queryParams: Dictionary = [:]
    var bodyParams: Dictionary = [:]
}
