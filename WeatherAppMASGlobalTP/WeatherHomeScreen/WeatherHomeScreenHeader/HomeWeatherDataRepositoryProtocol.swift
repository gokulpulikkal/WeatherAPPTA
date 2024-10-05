//
//  HomeWeatherDataRepositoryProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

protocol HomeWeatherHeaderDataRepositoryProtocol {

    func getCurrentWeather(cityName: String) async throws -> WeatherResponse

}

class HomeWeatherHeaderDataRepositoryProtocolMock: HomeWeatherHeaderDataRepositoryProtocol {

    var _getCurrentWeather: (() async throws -> WeatherResponse)?
    func setImplementationGetCurrentWeather(function: @escaping () async throws -> WeatherResponse) {
        _getCurrentWeather = {
            try await function()
        }
    }

    func getCurrentWeather(cityName: String) async throws -> WeatherResponse {
        guard let _getCurrentWeather else {
            throw RequestError.unknown // No mock set, do nothing
        }
        return try await _getCurrentWeather()
    }

}
