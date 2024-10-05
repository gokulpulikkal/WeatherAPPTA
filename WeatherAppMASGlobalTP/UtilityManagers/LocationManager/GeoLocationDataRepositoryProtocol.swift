//
//  GeoLocationDataRepositoryProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//

import Foundation

/// Protocol defining methods for obtaining city information based on geographical coordinates.
protocol GeoLocationDataRepositoryProtocol {

    /// Asynchronously fetch a list of cities from given latitude and longitude coordinates.
    func getCityFromCoordinates(lat: Double, long: Double) async throws -> [City]

}

/// Mock implementation of GeoLocationDataRepositoryProtocol for testing purposes.
class GeoLocationDataRepositoryProtocolMock: GeoLocationDataRepositoryProtocol {

    /// Closure to simulate the result of fetching cities based on coordinates.
    var cityResult: ((Double, Double) async throws -> [City])?

    /// Sets the mock implementation for retrieving cities from coordinates.
    /// - Parameter function: The async closure that will be called to simulate city retrieval.
    func setImplementationForCityFromCoordinates(function: @escaping (Double, Double) async throws -> [City]) {
        cityResult = function
    }

    /// Asynchronously fetch cities from the provided coordinates.
    func getCityFromCoordinates(lat: Double, long: Double) async throws -> [City] {
        guard let cityResult else {
            throw RequestError.unknown
        }
        return try await cityResult(lat, long)
    }

}
