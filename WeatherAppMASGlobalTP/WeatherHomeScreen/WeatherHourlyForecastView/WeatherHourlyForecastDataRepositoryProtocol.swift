//
//  WeatherHourlyForecastDataRepositoryProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

protocol WeatherHourlyForecastDataRepositoryProtocol {

    func getCurrentForecastWeather(cityName: String) async throws -> WeatherForecastResponse

}
