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
        
        var homeWeatherHeaderDataRepository: HomeWeatherHeaderDataRepositoryProtocol

        /// The state of retrieving the workout sessions to display in the log.
        var loadState: LoadState<WeatherResponse, any Error> = .loading

        init(navigation: LaunchNavigationProtocol? = nil, homeWeatherHeaderDataRepository: HomeWeatherHeaderDataRepositoryProtocol = HomeWeatherHeaderDataRepository()) {
            self.homeWeatherHeaderDataRepository = homeWeatherHeaderDataRepository
            self.navigation = navigation
        }
        
        func loadSearchScreen() {
            navigation?.goToSearchScreen()
        }
    }
}
