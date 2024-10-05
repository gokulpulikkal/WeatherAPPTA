//
//  CitySearchDataRepositoryProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

protocol CitySearchDataRepositoryProtocol {
    func getCityList(for cityName: String) async throws -> [City]
    func getCity(for cityZip: Int) async throws -> City
}

class CitySearchDataRepositoryProtocolMock: CitySearchDataRepositoryProtocol {

    var cityListResult: (() async throws -> [City])?
    /// Set the implementation that will be returned when `getCityList()` is called
    func setImplementationForGetCityList(function: @escaping (() async throws -> [City])) {
        cityListResult = function
    }

    func getCityList(for cityName: String) async throws -> [City] {
        guard let cityListResult else {
            throw RequestError.unknown
        }
        return try await cityListResult() // Pass the city name to the closure
    }

    var cityResult: (() async throws -> City)?
    /// Set the implementation that will be returned when `getCityList()` is called
    func setImplementationForGetCity(function: @escaping (() async throws -> City)) {
        cityResult = function
    }

    func getCity(for cityZip: Int) async throws -> City {
        guard let cityResult else {
            throw RequestError.unknown
        }
        return try await cityResult()
    }

}
