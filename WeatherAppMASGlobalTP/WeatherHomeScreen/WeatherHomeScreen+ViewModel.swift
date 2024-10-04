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

        var homeWeatherDataRepository: HomeWeatherDataRepositoryProtocol

        /// The state of retrieving the workout sessions to display in the log.
        var loadState: LoadState<WeatherResponse, any Error> = .loading

        init(homeWeatherDataRepository: HomeWeatherDataRepositoryProtocol = HomeWeatherDataRepository()) {
            self.homeWeatherDataRepository = homeWeatherDataRepository
        }

        func getCurrentWeatherData() async {
            do {
                let currentWeatherResponse = try await homeWeatherDataRepository.getCurrentWeather()
                loadState = .success(currentWeatherResponse)
            } catch {
                loadState = .failure(error)
            }
        }
    }
}
