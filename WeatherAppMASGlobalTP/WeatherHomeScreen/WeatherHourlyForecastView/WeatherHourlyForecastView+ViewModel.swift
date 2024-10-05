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

        /// A property that holds a reference to the WeatherHourlyForecastDataRepositoryProtocol for fetching weather
        /// data.
        var weatherHourlyForecastDataRepository: WeatherHourlyForecastDataRepositoryProtocol

        /// Load state variable to manage the loading status and result of fetching the weather data.
        var loadState: LoadState<WeatherForecastResponse, any Error> = .loading

        /// Initializer for the ViewModel that accepts a weather data repository.
        /// Defaults to a new instance of WeatherHourlyForecastDataRepository if none is provided.
        init(
            weatherHourlyForecastDataRepository: WeatherHourlyForecastDataRepositoryProtocol =
                WeatherHourlyForecastDataRepository()
        ) {
            self.weatherHourlyForecastDataRepository = weatherHourlyForecastDataRepository
        }

        /// Asynchronously fetch hourly weather data for a given city.
        func getHourlyWeatherData(city: City) async {
            do {
                let currentHourlyForecast = try await weatherHourlyForecastDataRepository
                    .getCurrentForecastWeather(cityName: city.name)
                loadState = .success(currentHourlyForecast)
            } catch {
                loadState = .failure(error)
            }
        }

    }
}
