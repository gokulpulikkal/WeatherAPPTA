//
//  HomeWeatherDataRepository.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

class HomeWeatherDataRepository: HomeWeatherDataRepositoryProtocol, NetworkServiceProtocol {

    func getCurrentWeather() async throws -> WeatherResponse {
        guard let request = Endpoint.getCurrentWeather.request else {
            throw RequestError.unknown
        }
        return try await networkManager.makeRequest(
            with: request,
            respModel: WeatherResponse.self
        )
    }
}
