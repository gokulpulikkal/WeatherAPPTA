//
//  Weather.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

struct WeatherOverall: Codable, Equatable {
    let id: Int
    let main: String
    let description: String
    let icon: String

    var iconURL: URL {
        URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!
    }
}
