//
//  WeatherHomeScreen+ViewModelTests.swift
//  WeatherAppMASGlobalTPTests
//
//  Created by Gokul P on 05/10/24.
//

import Testing
@testable import WeatherAppMASGlobalTP

struct WeatherHomeScreen_ViewModelTests {

    @Test
    func cityUpdateOnLocationFromLocationManagerTest() async throws {
        let city = City(name: "Buffalo", state: "NY", country: "US")
        let sut = WeatherHomeScreen.ViewModel(city: city)

        let newlyUpdatedCity = City(name: "New York City", state: "NY", country: "US")

        sut.updateLastUpdatedLocationCity(city: newlyUpdatedCity)

        // update with core location not enabled
        #expect(sut.city != newlyUpdatedCity)

        sut.shouldUpdateWithCoreLocation = true

        // update with core location enabled
        sut.updateLastUpdatedLocationCity(city: newlyUpdatedCity)
        #expect(sut.city == newlyUpdatedCity)
    }

}
