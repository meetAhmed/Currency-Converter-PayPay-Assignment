//
//  HTTPMethodType.swift
//  CurrencyConverter
//
//  Created by Ahmed Ali on 09/06/2023.
//

import Foundation

/**
 This is an enumeration called 'HTTPMethodType' that represents different types of HTTP methods.
 
 It defines cases for common HTTP methods:
 - 'get': Represents the GET method used for retrieving data.
 - 'head': Represents the HEAD method used for retrieving metadata of a resource.
 - 'post': Represents the POST method used for creating new resources.
 - 'put': Represents the PUT method used for replacing an entire resource.
 - 'patch': Represents the PATCH method used for partially updating a resource.
 - 'delete': Represents the DELETE method used for deleting a resource.
 
 Each case is associated with a raw value of type String representing the corresponding HTTP method.
 
 This enumeration can be used to specify the HTTP method for API requests.
 */
enum HTTPMethodType: String {
    case get
    case head
    case post
    case put
    case patch
    case delete
}
