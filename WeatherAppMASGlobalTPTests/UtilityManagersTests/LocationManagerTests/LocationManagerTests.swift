//
//  LocationManagerTests.swift
//  WeatherAppMASGlobalTPTests
//
//  Created by Gokul P on 05/10/24.
//

import CoreLocation
import Testing
@testable import WeatherAppMASGlobalTP

struct LocationManagerTests {

    @Test @MainActor
    func getCityFromLocationTest() async throws {
        let geoLocationDataRepository = GeoLocationDataRepositoryProtocolMock()
        let locationManagerMock = LocationManager(geoLocationDataRepository: geoLocationDataRepository)
        let cLLocation = CLLocationCoordinate2D(latitude: 12, longitude: 12)
        locationManagerMock.lastKnownLocation = cLLocation
        locationManagerMock.locationServiceIsActive = true

        let city = City(name: "Buffalo", state: "NY", country: "US")
        geoLocationDataRepository.setImplementationForCityFromCoordinates(function: { _, _ async throws in
            [city]
        })
        #expect(locationManagerMock.locationServiceIsActive)
        await locationManagerMock.getCityFromLocation()
        #expect(locationManagerMock.locationCity == city)
    }

}
