//
//  GeoLocationDataRepository.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//

import Foundation

class GeoLocationDataRepository: GeoLocationDataRepositoryProtocol, NetworkServiceProtocol {

    func getCityFromCoordinates(lat: Double, long: Double) async throws -> [City] {
        guard let request = Endpoint.getCityListFromCoordinates(
            lat: lat,
            long: long
        ).request
        else {
            throw RequestError.unknown
        }
        return try await networkManager.makeRequest(
            with: request,
            respModel: [City].self
        )
    }

}
