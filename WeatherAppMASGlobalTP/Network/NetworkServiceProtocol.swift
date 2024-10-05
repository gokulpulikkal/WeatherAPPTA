//
//  NetworkServiceProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

/// Protocol defining the requirements for any network service.
protocol NetworkServiceProtocol {
    var networkManager: APIService { get }
}

/// Extension providing a default implementation for the networkManager property.
extension NetworkServiceProtocol {
    var networkManager: APIService {
        APIService()
    }
}
