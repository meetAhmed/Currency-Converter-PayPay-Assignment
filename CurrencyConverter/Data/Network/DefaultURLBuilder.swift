//
//  DefaultURLBuilder.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 09/06/2023.
//

import Foundation

/**
 This is an enumeration called 'URLBuilderError' that represents errors related to URL building.
 
 It defines two cases:
 - 'invalidFullPath': Indicates an invalid full path for constructing a URL.
 - 'invalidURL': Indicates an invalid URL.
 
 This enumeration can be used to throw and handle errors when building URLs.
 */
enum URLBuilderError: Error {
    case invalidFullPath, invalidURL
}

/**
 This is an enumeration called 'DefaultURLBuilder' that provides a static method for building URLRequest objects.
 
 It contains a private static variable 'defaultQueryParams' which holds default query parameters as a dictionary.
 
 The static method 'build' takes an 'api' parameter of type 'APIConstructor' and returns a constructed URLRequest object.
 
 The method performs the following steps:
 1. Initializes a URLComponents object using the full path of the endpoint specified in the 'api' parameter.
 2. Throws an 'URLBuilderError.invalidFullPath' error if the URLComponents initialization fails.
 3. Builds query items by combining the default query parameters and the query parameters specified in the 'api' parameter.
 4. Assigns the built query items to the URLComponents.
 5. Throws an 'URLBuilderError.invalidURL' error if the URLComponents fails to create a valid URL.
 6. Creates a URLRequest object using the constructed URL.
 7. Sets the HTTP method of the URLRequest to the method specified in the 'api' parameter.
 8. Encodes and assigns the body parameters of the 'api' parameter to the URLRequest, if present.
 9. Returns the constructed URLRequest object.
 
 This enumeration can be used to build URLRequest objects with default query parameters and handle potential URL building errors.
 */
enum DefaultURLBuilder {
    private static var defaultQueryParams = ["app_id": ""]
    
    static func build(with api: APIConstructor) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: api.endpoint.fullPath) else {
            throw URLBuilderError.invalidFullPath
        }
        
        urlComponents.queryItems = buildQueryItems(defaultQueryParams, api.queryParams)
        
        guard let url = urlComponents.url else {
            throw URLBuilderError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.endpoint.method
        
        if !api.bodyParams.isEmpty {
            urlRequest.httpBody = encodeJsonBody(api.bodyParams)
        }
        
        return urlRequest
    }
}

/**
 This is a private extension of the 'DefaultURLBuilder' enumeration.
 
 It adds two static helper methods:
 - 'buildQueryItems': Takes a variadic parameter of type 'Dictionary' and returns an array of URLQueryItem objects.
 It combines the dictionaries passed as arguments, maps them to URLQueryItem objects, and returns the resulting array.
 - 'encodeJsonBody': Takes a parameter of type 'Dictionary' and returns a Data object.
 It attempts to serialize the dictionary as JSON data using JSONSerialization and returns the resulting data. If serialization fails, it returns nil.
 
 These helper methods are used internally within the 'DefaultURLBuilder' enumeration to build query items and encode JSON bodies.
 
 By defining them as private extensions, they are encapsulated within the 'DefaultURLBuilder' scope and not accessible outside.
 */
private extension DefaultURLBuilder {
    static func buildQueryItems(_ params: Dictionary...) -> [URLQueryItem] {
        params.flatMap { $0 }.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
    static func encodeJsonBody(_ params: Dictionary) -> Data? {
        try? JSONSerialization.data(withJSONObject: params)
    }
}
