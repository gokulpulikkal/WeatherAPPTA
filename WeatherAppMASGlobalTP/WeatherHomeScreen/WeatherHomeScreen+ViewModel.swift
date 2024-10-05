//
//  WeatherHomeScreen+ViewModel.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Observation
import SwiftUI

extension WeatherHomeScreen {

    @Observable
    final class ViewModel {

        weak var navigation: LaunchNavigationProtocol?

        var city: City

        var homeWeatherHeaderDataRepository: HomeWeatherHeaderDataRepositoryProtocol

        var shouldUpdateWithCoreLocation = false

        var lastUpdatedLocationFromCoreLocation: City?

        init(
            city: City,
            navigation: LaunchNavigationProtocol? = nil,
            homeWeatherHeaderDataRepository: HomeWeatherHeaderDataRepositoryProtocol = HomeWeatherHeaderDataRepository()
        ) {
            self.homeWeatherHeaderDataRepository = homeWeatherHeaderDataRepository
            self.navigation = navigation
            self.city = city
        }

        func loadSearchScreen() {
            navigation?.goToSearchScreen()
        }

        func updateLastUpdatedLocationCity(city: City?) {
            lastUpdatedLocationFromCoreLocation = city
            if shouldUpdateWithCoreLocation {
                updatedCity()
            }
        }

        func updatedCity() {
            guard let lastUpdatedCity = lastUpdatedLocationFromCoreLocation else {
                return
            }
            city = lastUpdatedCity
            shouldUpdateWithCoreLocation = false
        }
    }
}
