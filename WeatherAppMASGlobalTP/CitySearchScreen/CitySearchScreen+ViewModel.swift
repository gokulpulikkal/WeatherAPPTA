//
//  CitySearchScreen+ViewModel.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation
import Observation

extension CitySearchScreen {
    @Observable
    final class ViewModel {
        var searchIsActive = false
        var searchText = ""
        
        var citySearchDataRepository: CitySearchDataRepositoryProtocol
        var searchResultList: [City] = []

        init(citySearchDataRepository: CitySearchDataRepositoryProtocol = CitySearchDataRepository()) {
            self.citySearchDataRepository = citySearchDataRepository
        }
    }
}
