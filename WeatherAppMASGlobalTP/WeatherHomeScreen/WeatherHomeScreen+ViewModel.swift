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

        /// A weak reference to the navigation protocol for controlling navigation between screens
        weak var navigation: LaunchNavigationProtocol?

        /// The current city object which the weather data is being displayed for
        var city: City

        /// A flag to determine whether the city should be updated based on CoreLocation data
        var shouldUpdateWithCoreLocation = false

        /// Stores the last updated city object retrieved from CoreLocation, if available
        var lastUpdatedLocationFromCoreLocation: City?

        /// Initializer for the ViewModel, accepts a city object and an optional navigation protocol
        init(
            city: City,
            navigation: LaunchNavigationProtocol? = nil
        ) {
            self.navigation = navigation
            self.city = city
        }

        /// Triggers the navigation to the search screen
        func loadSearchScreen() {
            navigation?.goToSearchScreen()
        }

        /// Updates the city location based on CoreLocation, if available and enabled
        func updateLastUpdatedLocationCity(city: City?) {
            lastUpdatedLocationFromCoreLocation = city
            if shouldUpdateWithCoreLocation {
                updateCity()
            }
        }

        /// Updates the city property with the most recent CoreLocation data, if available
        private func updateCity() {
            guard let lastUpdatedCity = lastUpdatedLocationFromCoreLocation else {
                return
            }
            city = lastUpdatedCity
            shouldUpdateWithCoreLocation = false
        }
    }
}
