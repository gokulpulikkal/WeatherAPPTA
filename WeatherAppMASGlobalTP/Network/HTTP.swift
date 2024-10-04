//
//  HTTP.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

enum HTTP {

    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    enum Headers {

        enum Key: String {
            case contentType = "Content-Type"
            case authorization = "Authorization"
        }

        enum Value: String {
            case applicationJson = "application/json"
        }
    }
}
