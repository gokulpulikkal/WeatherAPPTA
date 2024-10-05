//
//  LaunchNavigationProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//

import Foundation

/// Protocol defining navigation actions for the launch flow of the application.
protocol LaunchNavigationProtocol: AnyObject {

    /// Method to navigate to the search screen.
    func goToSearchScreen()

    /// Method to set the home screen as the root view controller.
    func makeHomeScreenRoot()

    /// Method to pop the current screen from the navigation stack.
    func popScreenFromNavigation()
}
