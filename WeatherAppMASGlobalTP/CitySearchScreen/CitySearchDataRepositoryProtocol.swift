//
//  CitySearchDataRepositoryProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

protocol CitySearchDataRepositoryProtocol {
    func getCityList(for cityName: String) async throws -> [City]
    func getCity(for cityZip: Int) async throws -> City
}
