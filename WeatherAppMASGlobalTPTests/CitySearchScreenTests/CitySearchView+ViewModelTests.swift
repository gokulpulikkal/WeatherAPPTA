//
//  CitySearchView+ViewModelTests.swift
//  WeatherAppMASGlobalTPTests
//
//  Created by Gokul P on 05/10/24.
//

import Testing
@testable import WeatherAppMASGlobalTP

struct CitySearchView_ViewModelTests {

    private let citySearchDataRepository = CitySearchDataRepositoryProtocolMock()

    @Test
    func loadStateInitialTest() async throws {
        let sut = CitySearchView.ViewModel(citySearchDataRepository: citySearchDataRepository)
        #expect(sut.loadState == .loading)
    }

    @Test
    func citySearchTypeZipCodeTest() async throws {
        var didCallZipToCityFunction = false
        let city = City(name: "Buffalo", state: "NY", country: "US")
        citySearchDataRepository.setImplementationForGetCity {
            didCallZipToCityFunction = true
            return city
        }
        let sut = CitySearchView.ViewModel(citySearchDataRepository: citySearchDataRepository)
        await sut.performCitySearch(searchString: "Buffalo")
        #expect(didCallZipToCityFunction == false)
        
        await sut.performCitySearch(searchString: "14214")
        #expect(didCallZipToCityFunction == true)
    }

}
