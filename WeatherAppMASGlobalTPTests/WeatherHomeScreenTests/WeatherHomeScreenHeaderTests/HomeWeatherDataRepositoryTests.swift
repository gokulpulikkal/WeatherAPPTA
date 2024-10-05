//
//  HomeWeatherDataRepositoryTests.swift
//  WeatherAppMASGlobalTPTests
//
//  Created by Gokul P on 05/10/24.
//

import Testing
@testable import WeatherAppMASGlobalTP

struct HomeWeatherDataRepositoryTests {
    
    private let homeWeatherDataRepository = HomeWeatherHeaderDataRepositoryProtocolMock()

    @Test func getCurrentWeatherTest() async throws {
        let mockResponse = WeatherResponseMock.mockWeatherResponse()
        homeWeatherDataRepository.setImplementationGetCurrentWeather(function: {
            return mockResponse
        })
        let returnedValue = try await homeWeatherDataRepository.getCurrentWeather(cityName: "Buffalo")
        #expect(returnedValue == mockResponse)
    }

}
