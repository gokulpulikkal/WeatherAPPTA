//
//  HomeWeatherDataRepositoryProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

protocol HomeWeatherHeaderDataRepositoryProtocol {

    func getCurrentWeather(cityName: String) async throws -> WeatherResponse

}
