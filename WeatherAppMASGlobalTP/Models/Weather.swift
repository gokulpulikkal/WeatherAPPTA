//
//  Weather.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

struct WeatherOverall: Codable, Equatable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
