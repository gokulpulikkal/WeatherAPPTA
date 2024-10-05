//
//  WeatherHomeHeaderView+ViewModelTests.swift
//  WeatherAppMASGlobalTPTests
//
//  Created by Gokul P on 05/10/24.
//

import Testing
@testable import WeatherAppMASGlobalTP

struct WeatherHomeHeaderView_ViewModelTests {

    private let homeWeatherDataRepository = HomeWeatherHeaderDataRepositoryProtocolMock()

    @Test(arguments: [
        City(name: "Buffalo", state: "NY", country: "US"),
        City(name: "Ohio", state: "NY", country: "US")
    ])
    func initialLoadStateTest(city: City) {
        let viewModel = WeatherHomeHeaderView.ViewModel(homeWeatherHeaderDataRepository: homeWeatherDataRepository)
        #expect(viewModel.loadState == .loading)
    }

    @Test
    func getCurrentWeatherDataTest() async {
        let mockResponse = WeatherResponseMock.mockWeatherResponse()
        homeWeatherDataRepository.setImplementationGetCurrentWeather(function: {
            mockResponse
        })
        let viewModel = WeatherHomeHeaderView.ViewModel(homeWeatherHeaderDataRepository: homeWeatherDataRepository)
        #expect(viewModel.loadState == .loading)

        let city = City(name: "Ohio", state: "NY", country: "US")
        await viewModel.getCurrentWeatherData(city: city)
        #expect(viewModel.loadState == .success(mockResponse))
    }

}
