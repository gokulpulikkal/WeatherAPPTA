//
//  WeatherHourlyForecastView+ViewModel.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation
import Observation

extension WeatherHourlyForecastView {

    @Observable
    final class ViewModel {

        var weatherHourlyForecastDataRepository: WeatherHourlyForecastDataRepositoryProtocol

        var loadState: LoadState<WeatherForecastResponse, any Error> = .loading

        init(
            weatherHourlyForecastDataRepository: WeatherHourlyForecastDataRepositoryProtocol =
                WeatherHourlyForecastDataRepository()
        ) {
            self.weatherHourlyForecastDataRepository = weatherHourlyForecastDataRepository
        }

        func getHourlyWeatherData() async {
            do {
                let currentHourlyForecast = try await weatherHourlyForecastDataRepository.getCurrentForecastWeather()
                loadState = .success(currentHourlyForecast)
            } catch {
                loadState = .failure(error)
            }
        }

    }
}
