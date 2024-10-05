//
//  GeoLocationDataRepositoryTests.swift
//  WeatherAppMASGlobalTPTests
//
//  Created by Gokul P on 05/10/24.
//

import Testing
@testable import WeatherAppMASGlobalTP

struct GeoLocationDataRepositoryTests {
    
    let geoLocationDataRepository = GeoLocationDataRepositoryProtocolMock()

    @Test func geoLocationDecodingTest() async throws {
        let city = City(name: "Buffalo", state: "NY", country: "US")
        geoLocationDataRepository.setImplementationForCityFromCoordinates(function: { lat, long async throws in
            return [city]
        })
        
        let returnedCity = try await geoLocationDataRepository.getCityFromCoordinates(lat: 12, long: 12)
        #expect(returnedCity == [city])
    }

}
