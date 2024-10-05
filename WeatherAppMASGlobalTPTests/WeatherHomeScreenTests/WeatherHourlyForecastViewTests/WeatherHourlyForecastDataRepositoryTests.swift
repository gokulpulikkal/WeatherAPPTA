//
//  WeatherHourlyForecastDataRepositoryTests.swift
//  WeatherAppMASGlobalTPTests
//
//  Created by Gokul P on 05/10/24.
//

import Testing
@testable import WeatherAppMASGlobalTP

struct WeatherHourlyForecastDataRepositoryTests {

    private let weatherHourlyForecastDataRepository = WeatherHourlyForecastDataRepositoryProtocolMock()

    @Test
    func getCurrentForecastWeather() async throws {
        let mockResponse = WeatherForecastResponseMock.mockWeatherForecastResponse()
        weatherHourlyForecastDataRepository.setImplementationGetCurrentWeatherForecast(function: {
            mockResponse
        })
        let returnedValue = try await weatherHourlyForecastDataRepository.getCurrentForecastWeather(cityName: "Buffalo")
        #expect(returnedValue == mockResponse)
    }

}
