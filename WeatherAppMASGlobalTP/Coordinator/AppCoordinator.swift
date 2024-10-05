//
//  AppCoordinator.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation
import SwiftUI
import UIKit

/// AppCoordinator class responsible for managing the app's navigation flow.
class AppCoordinator: Coordinator {

    /// Reference to the parent coordinator
    var parentCoordinator: Coordinator?

    /// Array to hold child coordinators.
    var children: [Coordinator] = []

    /// UINavigationController to manage navigation stack.
    var navigationController: UINavigationController

    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }

    /// Starts the navigation flow of the app.
    func start() {
        if let city = UserDefaultsManager.shared.load(
            forKey: Constants.UserDefaultKeys.savedCity.rawValue,
            as: City.self
        ) {
            navigationController.pushViewController(
                UIHostingController(rootView: WeatherHomeScreen(
                    viewModel: WeatherHomeScreen
                        .ViewModel(city: city, navigation: self)
                )),
                animated: true
            )
        } else {
            navigationController.pushViewController(
                UIHostingController(rootView: CitySearchView(
                    viewModel: CitySearchView
                        .ViewModel(navigation: self)
                )),
                animated: true
            )
        }
    }
}

// MARK: - LaunchNavigationProtocol

/// Extending AppCoordinator to conform to LaunchNavigationProtocol.
extension AppCoordinator: LaunchNavigationProtocol {

    /// Navigate to the search screen.
    func goToSearchScreen() {
        navigationController.pushViewController(
            UIHostingController(rootView: CitySearchView(viewModel: CitySearchView.ViewModel(navigation: self))),
            animated: true
        )
    }

    /// Set the home screen as the root view controller.
    func makeHomeScreenRoot() {
        if let city = UserDefaultsManager.shared.load(
            forKey: Constants.UserDefaultKeys.savedCity.rawValue,
            as: City.self
        ) {
            navigationController.setViewControllers([UIHostingController(rootView: WeatherHomeScreen(
                viewModel: WeatherHomeScreen
                    .ViewModel(city: city, navigation: self)
            ))], animated: true)
        }
    }

    /// Pop the current screen from the navigation stack.
    func popScreenFromNavigation() {
        navigationController.popViewController(animated: true)
    }
}
