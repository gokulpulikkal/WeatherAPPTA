//
//  WeatherHourlyForecastDataRepositoryProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

/// Protocol that defines the interface for a weather forecast data repository.
/// It has one function to fetch the weather forecast based on the city name.
protocol WeatherHourlyForecastDataRepositoryProtocol {

    /// Asynchronously fetches the weather forecast for the specified city.
    /// Returns a `WeatherForecastResponse` or throws an error if the request fails.
    func getCurrentForecastWeather(cityName: String) async throws -> WeatherForecastResponse

}

/// Mock class that conforms to `WeatherHourlyForecastDataRepositoryProtocol`.
/// This class is used for testing, allowing us to simulate the behavior of fetching weather data.
class WeatherHourlyForecastDataRepositoryProtocolMock: WeatherHourlyForecastDataRepositoryProtocol {

    /// A closure that can be set to mock the behavior of fetching the weather forecast.
    /// It's optional, so it can be nil if no mock implementation is set.
    var _getCurrentWeatherForecast: (() async throws -> WeatherForecastResponse)?

    /// Function to set the mock implementation for fetching the weather forecast.
    /// It allows tests to define what happens when `getCurrentForecastWeather` is called.
    func setImplementationGetCurrentWeatherForecast(function: @escaping () async throws -> WeatherForecastResponse) {
        _getCurrentWeatherForecast = {
            try await function()
        }
    }

    /// Implementation of the `getCurrentForecastWeather` method from the protocol.
    /// It calls the mock implementation if it has been set; otherwise, throws an error.
    func getCurrentForecastWeather(cityName: String) async throws -> WeatherForecastResponse {
        guard let _getCurrentWeatherForecast else {
            throw RequestError.unknown // No mock set, do nothing
        }
        return try await _getCurrentWeatherForecast()
    }

}
