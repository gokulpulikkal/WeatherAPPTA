//
//  CitySearchDataRepositoryProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

/// Protocol defining the methods for fetching city data.
protocol CitySearchDataRepositoryProtocol {

    /// Asynchronously fetches a list of cities based on the provided city name.
    func getCityList(for cityName: String) async throws -> [City]

    /// Asynchronously fetches a city based on the provided ZIP code.
    func getCity(for cityZip: Int) async throws -> City
}

/// Mock implementation of CitySearchDataRepositoryProtocol for testing purposes.
class CitySearchDataRepositoryProtocolMock: CitySearchDataRepositoryProtocol {

    /// A closure that simulates the result of fetching a city list.
    var cityListResult: (() async throws -> [City])?

    /// Sets the implementation that will be returned when `getCityList()` is called.
    /// - Parameter function: A closure that returns an array of City objects asynchronously.
    func setImplementationForGetCityList(function: @escaping (() async throws -> [City])) {
        cityListResult = function
    }

    /// Asynchronously fetches a list of cities based on the provided city name.
    func getCityList(for cityName: String) async throws -> [City] {
        guard let cityListResult else {
            throw RequestError.unknown
        }
        return try await cityListResult() // Pass the city name to the closure
    }

    /// A closure that simulates the result of fetching a single city.
    var cityResult: (() async throws -> City)?

    /// Sets the implementation that will be returned when `getCity()` is called.
    /// - Parameter function: A closure that returns a City object asynchronously.
    func setImplementationForGetCity(function: @escaping (() async throws -> City)) {
        cityResult = function
    }

    /// Asynchronously fetches a city based on the provided ZIP code.
    func getCity(for cityZip: Int) async throws -> City {
        guard let cityResult else {
            throw RequestError.unknown
        }
        return try await cityResult()
    }

}
