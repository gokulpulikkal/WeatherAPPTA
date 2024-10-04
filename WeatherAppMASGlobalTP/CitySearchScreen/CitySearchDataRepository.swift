//
//  CitySearchDataRepository.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

class CitySearchDataRepository: CitySearchDataRepositoryProtocol, NetworkServiceProtocol {

    func getCityList(for cityName: String) async throws -> [City] {
        guard let request = Endpoint.getCityList(cityName: cityName).request else {
            throw RequestError.unknown
        }
        return try await networkManager.makeRequest(
            with: request,
            respModel: [City].self
        )
    }

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
