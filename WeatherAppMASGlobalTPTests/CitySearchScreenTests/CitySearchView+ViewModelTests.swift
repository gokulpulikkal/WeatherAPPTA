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
    func cityZipCodeSearchFunctionInvokeTest() async throws {
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

    @Test
    func cityNameSearchFunctionInvokeTest() async throws {
        var didCallNameToCityFunction = false
        let city = City(name: "Buffalo", state: "NY", country: "US")
        citySearchDataRepository.setImplementationForGetCityList {
            didCallNameToCityFunction = true
            return [city]
        }
        let sut = CitySearchView.ViewModel(citySearchDataRepository: citySearchDataRepository)

        await sut.performCitySearch(searchString: "14214")
        #expect(didCallNameToCityFunction == false)

        await sut.performCitySearch(searchString: "Buffalo")
        #expect(didCallNameToCityFunction == true)
    }

    @Test("Search user performs", arguments: [
        "14214",
        "Buffalo"
    ])
    func citySearchTest(searchString: String) async throws {
        let cityList = [
            City(name: "Buffalo", state: "NY", country: "US")
        ]

        citySearchDataRepository.setImplementationForGetCityList {
            cityList
        }

        citySearchDataRepository.setImplementationForGetCity {
            cityList[0]
        }

        let sut = CitySearchView.ViewModel(citySearchDataRepository: citySearchDataRepository)
        #expect(sut.loadState == .loading)

        await sut.performCitySearch(searchString: searchString)
        #expect(sut.loadState == .success(cityList))
    }
}
