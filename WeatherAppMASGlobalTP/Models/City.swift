//
//  City.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

struct City: Codable, Equatable, Hashable {
    let name: String
    let state: String?
    let country: String
}
