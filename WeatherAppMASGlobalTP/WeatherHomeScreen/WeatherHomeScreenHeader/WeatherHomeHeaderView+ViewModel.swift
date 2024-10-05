//
//  WeatherHomeHeaderView+ViewModel.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation
import Observation

extension WeatherHomeHeaderView {
    @Observable
    final class ViewModel {

        var homeWeatherHeaderDataRepository: HomeWeatherHeaderDataRepositoryProtocol

        var loadState: LoadState<WeatherResponse, any Error> = .loading

        init(
            homeWeatherHeaderDataRepository: HomeWeatherHeaderDataRepositoryProtocol =
                HomeWeatherHeaderDataRepository()
        ) {
            self.homeWeatherHeaderDataRepository = homeWeatherHeaderDataRepository
        }

        func getCurrentWeatherData(city: City) async {
            do {
                let currentWeatherResponse = try await homeWeatherHeaderDataRepository.getCurrentWeather(cityName: city.name)
                loadState = .success(currentWeatherResponse)
            } catch {
                loadState = .failure(error)
            }
        }
    }
}
