//
//  CitySearchDataRepository.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

/// Class that conforms to CitySearchDataRepositoryProtocol and NetworkServiceProtocol,
/// responsible for fetching city data from a network service.
class CitySearchDataRepository: CitySearchDataRepositoryProtocol, NetworkServiceProtocol {

    /// Asynchronously fetches a list of cities based on the provided city name.
    /// - Parameter cityName: The name of the city for which to fetch a list of matching cities.
    /// - Throws: RequestError.unknown if the request cannot be created or if there's an error during the network
    /// request.
    /// - Returns: An array of City objects.
    func getCityList(for cityName: String) async throws -> [City] {
        guard let request = Endpoint.getCityList(cityName: cityName).request else {
            throw RequestError.unknown
        }
        return try await networkManager.makeRequest(
            with: request,
            respModel: [City].self
        )
    }

    /// Asynchronously fetches a city based on the provided ZIP code.
    /// - Parameter cityZip: The ZIP code of the city to be fetched.
    /// - Throws: RequestError.unknown if the request cannot be created or if there's an error during the network
    /// request.
    /// - Returns: A City object corresponding to the provided ZIP code.
    func getCity(for cityZip: Int) async throws -> City {
        guard let request = Endpoint.getCity(cityZip: cityZip).request else {
            throw RequestError.unknown
        }
        return try await networkManager.makeRequest(
            with: request,
            respModel: City.self
        )
    }
}
