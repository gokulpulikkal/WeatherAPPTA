//
//  AppCoordinator.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation
import SwiftUI
import UIKit

class AppCoordinator: Coordinator {

    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }

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

extension AppCoordinator: LaunchNavigationProtocol {
    func goToSearchScreen() {
        navigationController.pushViewController(
            UIHostingController(rootView: CitySearchView(viewModel: CitySearchView.ViewModel(navigation: self))),
            animated: true
        )
    }

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

    func popScreenFromNavigation() {
        navigationController.popViewController(animated: true)
    }
}
