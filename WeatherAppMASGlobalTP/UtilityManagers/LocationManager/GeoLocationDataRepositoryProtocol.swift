//
//  GeoLocationDataRepositoryProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//

import Foundation

protocol GeoLocationDataRepositoryProtocol {
    
    func getCityFromCoordinates(lat: Double, long: Double) async throws -> [City]
    
}
