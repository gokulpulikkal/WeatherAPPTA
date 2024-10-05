//
//  GeoLocationDataRepositoryProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//

import Foundation

protocol GeoLocationDataRepositoryProtocol {

    func getCityFromCoordinates(lat: Double, long: Double) async throws -> [City]

}

class GeoLocationDataRepositoryProtocolMock: GeoLocationDataRepositoryProtocol {

    /// Closure for save(_:forKey:) function
    var cityResult: ((Double, Double) async throws -> [City])?

    /// Set the mock implementation for saving
    func setImplementationForCityFromCoordinates(function: @escaping (Double, Double) async throws -> [City]) {
        cityResult = function
    }

    func getCityFromCoordinates(lat: Double, long: Double) async throws -> [City] {
        guard let cityResult else {
            throw RequestError.unknown
        }
        return try await cityResult(lat, long)
    }

}
