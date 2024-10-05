//
//  WeatherHourlyForecastDataRepositoryProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

protocol WeatherHourlyForecastDataRepositoryProtocol {

    func getCurrentForecastWeather(cityName: String) async throws -> WeatherForecastResponse

}

class WeatherHourlyForecastDataRepositoryProtocolMock: WeatherHourlyForecastDataRepositoryProtocol {

    var _getCurrentWeatherForecast: (() async throws -> WeatherForecastResponse)?
    func setImplementationGetCurrentWeatherForecast(function: @escaping () async throws -> WeatherForecastResponse) {
        _getCurrentWeatherForecast = {
            try await function()
        }
    }

    func getCurrentForecastWeather(cityName: String) async throws -> WeatherForecastResponse {
        guard let _getCurrentWeatherForecast else {
            throw RequestError.unknown // No mock set, do nothing
        }
        return try await _getCurrentWeatherForecast()
    }

}
