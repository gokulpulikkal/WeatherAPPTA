//
//  CitySearchView+ViewModel.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation
import Observation
import SwiftUI

extension CitySearchView {

    @Observable
    final class ViewModel {

        let citySearchDataRepository: CitySearchDataRepositoryProtocol

        var searchResultList: [City] = []

        var loadState: LoadState<[City], any Error> = .loading
        
        weak var navigation: LaunchNavigationProtocol?

        init(navigation: LaunchNavigationProtocol? = nil, citySearchDataRepository: CitySearchDataRepositoryProtocol = CitySearchDataRepository()) {
            self.citySearchDataRepository = citySearchDataRepository
            self.navigation = navigation
        }

        @MainActor
        func saveSelectedCity(city: City) async {
            await UserDefaultsManager.shared.save(
                city,
                forKey: Constants.UserDefaultKeys.savedCity.rawValue
            )
            navigation?.makeHomeScreenRoot()
        }

        func performCitySearch(searchString: String) async {
            guard searchString.count >= 3 else {
                loadState = .loading
                return
            }
            let isZipCode = searchString.allSatisfy(\.isNumber)

            if isZipCode {
                guard searchString.count >= 5, let zipCode = Int(searchString) else {
                    return
                }
                do {
                    let city = try await citySearchDataRepository.getCity(for: zipCode)
                    loadState = .success([city])
                } catch {
                    loadState = .failure(error)
                    return
                }
            } else {
                do {
                    let cityList = try await citySearchDataRepository.getCityList(for: searchString)
                    if Task.isCancelled {
                        return
                    }
                    loadState = .success(cityList)
                } catch {
                    loadState = .failure(error)
                }
            }
        }
    }
}
