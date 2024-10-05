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

        let city: City

        var homeWeatherHeaderDataRepository: HomeWeatherHeaderDataRepositoryProtocol

        /// The state of retrieving the workout sessions to display in the log.
        var loadState: LoadState<WeatherResponse, any Error> = .loading

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
    }
}
