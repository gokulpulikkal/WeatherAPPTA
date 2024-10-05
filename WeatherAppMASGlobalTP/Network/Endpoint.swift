//
//  Endpoint.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

/// Enum to define various API endpoints
enum Endpoint {

    /// Endpoint for fetching current weather by city name.
    case getCurrentWeather(cityName: String)

    /// Endpoint for fetching hourly forecast by city name.
    case getHourlyForecast(cityName: String)

    /// Endpoint for fetching a list of cities by city name.
    case getCityList(cityName: String)

    /// Endpoint for fetching city information by ZIP code.
    case getCity(cityZip: Int)

    /// Endpoint for fetching city list from geographical coordinates.
    case getCityListFromCoordinates(lat: Double, long: Double)

    /// Computed property to create a URLRequest for the endpoint.
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

    /// Computed property to build the URL for the endpoint.
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

    /// Computed property to define the endpoint path based on the case.
    private var path: String {
        switch self {
        case .getCurrentWeather:
            "/data/2.5/weather"
        case .getHourlyForecast:
            "/data/2.5/forecast"
        case .getCityList:
            "/geo/1.0/direct"
        case .getCity:
            "/geo/1.0/zip"
        case .getCityListFromCoordinates:
            "/geo/1.0/reverse"
        }
    }

    /// Computed property to define the query items needed for the request.
    private var queryItems: [URLQueryItem] {
        switch self {
        case let .getCurrentWeather(cityName),
             let .getHourlyForecast(cityName):
            [
                URLQueryItem(name: "q", value: cityName),
                URLQueryItem(name: "appid", value: "93fc112871e2f24aba37f420bf035e68"),
                URLQueryItem(name: "units", value: "metric")
            ]
        case let .getCityList(cityName):
            [
                URLQueryItem(name: "q", value: cityName),
                URLQueryItem(name: "appid", value: "93fc112871e2f24aba37f420bf035e68"),
                URLQueryItem(name: "limit", value: "\(5)")
            ]
        case let .getCity(zipCode):
            [
                URLQueryItem(name: "zip", value: "\(zipCode)"),
                URLQueryItem(name: "appid", value: "93fc112871e2f24aba37f420bf035e68")
            ]
        case let .getCityListFromCoordinates(lat, long):
            [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(long)"),
                URLQueryItem(name: "appid", value: "93fc112871e2f24aba37f420bf035e68"),
                URLQueryItem(name: "limit", value: "\(5)")
            ]
        }
    }

    /// Computed property to define the HTTP method used for the request.
    private var httpMethod: String {
        switch self {
        case .getCurrentWeather,
             .getHourlyForecast,
             .getCityList,
             .getCity,
             .getCityListFromCoordinates:
            HTTP.Method.get.rawValue
        }
    }

    /// Computed property to define the HTTP body
    private var httpBody: Data? {
        switch self {
        default:
            nil
        }
    }

    /// Computed property to define the base URL for the API.
    private var baseURL: String? {
        switch self {
        default:
            "api.openweathermap.org"
        }
    }

    /// Computed property to define the scheme for the API (http or https).
    private var scheme: String? {
        switch self {
        default:
            "https"
        }
    }

    /// Computed property to define the port for the API.
    private var port: Int? {
        switch self {
        default:
            nil
        }
    }
}

/// Extension to add values to URLRequest for specific endpoints.
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
