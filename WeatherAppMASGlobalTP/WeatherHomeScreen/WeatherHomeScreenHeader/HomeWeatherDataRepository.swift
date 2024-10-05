//
//  HomeWeatherDataRepository.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

class HomeWeatherHeaderDataRepository: HomeWeatherHeaderDataRepositoryProtocol, NetworkServiceProtocol {

    func getCurrentWeather(cityName: String) async throws -> WeatherResponse {
        guard let request = Endpoint.getCurrentWeather(cityName: cityName).request else {
            throw RequestError.unknown
        }
        return try await networkManager.makeRequest(
            with: request,
            respModel: WeatherResponse.self
        )
    }
}
