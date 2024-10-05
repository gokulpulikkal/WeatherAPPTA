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

    /// ViewModel class for managing the state and logic of the CitySearchView.
    @Observable
    final class ViewModel {

        /// Property to access the city search data repository.
        let citySearchDataRepository: CitySearchDataRepositoryProtocol

        /// Array to hold the search results for cities.
        var searchResultList: [City] = []

        /// Property to manage the loading state of the city search results.
        var loadState: LoadState<[City], any Error> = .loading

        /// Weak reference to the navigation protocol to manage screen transitions.
        weak var navigation: LaunchNavigationProtocol?

        /// Initializer for the ViewModel.
        /// - Parameter navigation: An optional navigation protocol to handle navigation actions.
        /// - Parameter citySearchDataRepository: A repository for city search data, defaulting to a new
        /// CitySearchDataRepository.
        init(
            navigation: LaunchNavigationProtocol? = nil,
            citySearchDataRepository: CitySearchDataRepositoryProtocol = CitySearchDataRepository()
        ) {
            self.citySearchDataRepository = citySearchDataRepository
            self.navigation = navigation
            self.loadState = .loading
        }

        /// Asynchronously saves the selected city to UserDefaults and navigates to the home screen.
        /// - Parameter city: The City object to be saved.
        @MainActor
        func saveSelectedCity(city: City) async {
            await UserDefaultsManager.shared.save(
                city,
                forKey: Constants.UserDefaultKeys.savedCity.rawValue
            )
            navigation?.makeHomeScreenRoot()
        }

        /// Asynchronously performs a search for a city based on the provided search string.
        /// - Parameter searchString: The string to search for cities, which can be either a city name or ZIP code.
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
                    searchResultList = cityList
                    loadState = .success(cityList)
                } catch {
                    loadState = .failure(error)
                }
            }
        }
    }
}
