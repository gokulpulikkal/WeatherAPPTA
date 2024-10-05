//
//  WeatherHourlyForecastView+ViewModelTests.swift
//  WeatherAppMASGlobalTPTests
//
//  Created by Gokul P on 05/10/24.
//

import Testing
@testable import WeatherAppMASGlobalTP

struct WeatherHourlyForecastView_ViewModelTests {

    private let weatherHourlyForecastDataRepository = WeatherHourlyForecastDataRepositoryProtocolMock()

    @Test(arguments: [
        City(name: "Buffalo", state: "NY", country: "US"),
        City(name: "Ohio", state: "NY", country: "US")
    ])
    func initialLoadStateTest(city: City) {
        let viewModel = WeatherHourlyForecastView
            .ViewModel(weatherHourlyForecastDataRepository: weatherHourlyForecastDataRepository)
        #expect(viewModel.loadState == .loading)
    }

    @Test
    func getHourlyWeatherDataTest() async {
        let mockResponse = WeatherForecastResponseMock.mockWeatherForecastResponse()
        weatherHourlyForecastDataRepository.setImplementationGetCurrentWeatherForecast(function: {
            mockResponse
        })
        
        let viewModel = WeatherHourlyForecastView
            .ViewModel(weatherHourlyForecastDataRepository: weatherHourlyForecastDataRepository)
        #expect(viewModel.loadState == .loading)

        let city = City(name: "Ohio", state: "NY", country: "US")
        await viewModel.getHourlyWeatherData(city: city)
        #expect(viewModel.loadState == .success(mockResponse))
    }

}
