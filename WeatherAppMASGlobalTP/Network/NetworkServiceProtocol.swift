//
//  NetworkServiceProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

protocol NetworkServiceProtocol {
    var networkManager: APIService { get }
}

extension NetworkServiceProtocol {
    var networkManager: APIService {
        return APIService()
    }
}
