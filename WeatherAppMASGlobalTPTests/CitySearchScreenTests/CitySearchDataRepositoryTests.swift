//
//  CitySearchDataRepositoryTests.swift
//  WeatherAppMASGlobalTPTests
//
//  Created by Gokul P on 05/10/24.
//

import Testing
@testable import WeatherAppMASGlobalTP

struct CitySearchDataRepositoryTests {

    private let citySearchDataRepository = CitySearchDataRepositoryProtocolMock()

    @Test
    func getCityListFunctionReturnTest() async throws {
        let cityList = [
            City(name: "Buffalo", state: "NY", country: "US"),
            City(name: "New York", state: "NY", country: "US")
        ]
        citySearchDataRepository.setImplementationForGetCityList {
            return cityList
        }
        
        let returnedValue = try await citySearchDataRepository.getCityList(for: "Buffalo")
        #expect(returnedValue == cityList)
    }

}
