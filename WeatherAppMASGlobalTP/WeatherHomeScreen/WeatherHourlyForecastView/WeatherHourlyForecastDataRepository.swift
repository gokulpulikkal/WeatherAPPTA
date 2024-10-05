//
//  WeatherHourlyForecastDataRepository.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

class WeatherHourlyForecastDataRepository: WeatherHourlyForecastDataRepositoryProtocol, NetworkServiceProtocol {

    func getCurrentForecastWeather(cityName: String) async throws -> WeatherForecastResponse {
        guard let request = Endpoint.getHourlyForecast(cityName: cityName).request else {
            throw RequestError.unknown
        }
        return try await networkManager.makeRequest(
            with: request,
            respModel: WeatherForecastResponse.self
        )
    }
}
