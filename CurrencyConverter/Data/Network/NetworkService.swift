//
//  NetworkService.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 09/06/2023.
//

import Foundation

/**
 This is an enumeration called 'NetworkServiceError' that represents errors related to network services.
 
 It defines a single case:
 - 'invalidStatusCode': Indicates an invalid status code received from a network service.
 
 This enumeration can be used to throw and handle errors related to network services, such as invalid status codes.
 */
enum NetworkServiceError: Error {
    case invalidStatusCode
}

/**
 This is an actor called 'NetworkService' that provides methods for executing network requests.
 
 The actor includes the following methods:
 
 - 'executeRequest<T: Decodable>(for api: APIConstructor) async throws -> T':
 Executes an asynchronous network request for the specified 'api' parameter, which is an instance of 'APIConstructor'.
 It uses the 'DefaultURLBuilder' to build a URLRequest, performs the request using URLSession.shared.data(for:),
 and retrieves the data and response.
 It checks if the response has a valid status code (between 200 and 299), and if so, it decodes the response data to the specified type 'T' using JSONDecoder.
 If any error occurs during the request or decoding, it throws an error.
 
 - 'executeRequest(for url: URL) async throws -> Data':
 Executes an asynchronous network request for the specified 'url' parameter.
 It performs the request using URLSession.shared.data(from:), retrieves the data and response,
 and checks if the response has a valid status code.
 If the response has a valid status code, it returns the retrieved data.
 If the response has an invalid status code or any error occurs during the request, it throws an error.
 
 These methods can be used to execute network requests asynchronously and handle any errors that may occur during the process.
 The actor ensures that requests are executed sequentially, eliminating the need for external synchronization mechanisms.
 */
actor NetworkService {
    func executeRequest<T: Decodable>(for api: APIConstructor) async throws -> T {
        let urlRequest = try DefaultURLBuilder.build(with: api)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {
            throw NetworkServiceError.invalidStatusCode
        }
        let parsedData = try JSONDecoder().decode(T.self, from: data)
        return parsedData
    }
    
    func executeRequest(for url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {
            throw NetworkServiceError.invalidStatusCode
        }
        return data
    }
}
