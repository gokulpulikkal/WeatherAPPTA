//
//  WeatherHourlyForecastDataRepository.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

/// This class implements the WeatherHourlyForecastDataRepositoryProtocol and NetworkServiceProtocol.
/// It is responsible for fetching the hourly weather forecast for a given city from the network.
class WeatherHourlyForecastDataRepository: WeatherHourlyForecastDataRepositoryProtocol, NetworkServiceProtocol {

    /// Function that fetches the current weather forecast for a city.
    /// Takes the city name as input, returns a WeatherForecastResponse asynchronously.
    /// Throws an error if the request fails or is invalid.
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
