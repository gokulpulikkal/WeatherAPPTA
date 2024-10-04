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

        var homeWeatherHeaderDataRepository: HomeWeatherHeaderDataRepositoryProtocol

        /// The state of retrieving the workout sessions to display in the log.
        var loadState: LoadState<WeatherResponse, any Error> = .loading

        init(homeWeatherHeaderDataRepository: HomeWeatherHeaderDataRepositoryProtocol = HomeWeatherHeaderDataRepository()) {
            self.homeWeatherHeaderDataRepository = homeWeatherHeaderDataRepository
        }

        func getCurrentWeatherData() async {
            do {
                let currentWeatherResponse = try await homeWeatherHeaderDataRepository.getCurrentWeather()
                loadState = .success(currentWeatherResponse)
            } catch {
                loadState = .failure(error)
            }
        }
    }
}
