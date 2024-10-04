//
//  WeatherForecastResponse.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//


struct WeatherForecastResponse: Codable, Equatable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherForecastEntry]
}
