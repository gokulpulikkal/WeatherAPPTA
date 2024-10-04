//
//  Endpoint.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

enum Endpoint {

    case getCurrentWeather

    var request: URLRequest? {
        guard let url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        request.addValues(for: self)
        return request
    }

    private var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.port = port
        components.path = path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        return components.url
    }

    private var path: String {
        switch self {
        case .getCurrentWeather:
            "/data/2.5//weather"
        }
    }

    private var queryItems: [URLQueryItem] {
        switch self {
        case .getCurrentWeather:
            [
                URLQueryItem(name: "lat", value: "\(44.34)"),
                URLQueryItem(name: "lon", value: "\(10.99)"),
                URLQueryItem(name: "appid", value: "93fc112871e2f24aba37f420bf035e68")
            ]
        }
    }

    private var httpMethod: String {
        switch self {
        case .getCurrentWeather:
            HTTP.Method.get.rawValue
        }
    }

    private var httpBody: Data? {
        switch self {
        default:
            nil
        }
    }

    private var baseURL: String? {
        switch self {
        default:
            "api.openweathermap.org"
        }
    }

    private var scheme: String? {
        switch self {
        default:
            "https"
        }
    }

    private var port: Int? {
        switch self {
        default:
            nil
        }
    }
}

extension URLRequest {
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        default:
            setValue(
                HTTP.Headers.Value.applicationJson.rawValue,
                forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue
            )
        }
    }
}
