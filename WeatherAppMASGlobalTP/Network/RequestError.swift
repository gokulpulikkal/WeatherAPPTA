//
//  RequestError.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

/// Enum to represent different types of errors that can occur during a network request.
enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorised
    case unexpectedStatusCode
    case unknown

    var customMessage: String {
        switch self {
        case .decode:
            "Decode error"
        case .unauthorised:
            "Session expired"
        default:
            "Unknown error"
        }
    }
}
