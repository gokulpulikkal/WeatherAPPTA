//
//  WeatherResponse.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

struct WeatherResponse: Codable, Equatable {
    let weather: [WeatherOverall]
    let main: WeatherDetails
    let name: String
}
