//
//  CoordinatorProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation
import UIKit

/// Protocol defining the structure and behavior for a Coordinator in the app.
protocol Coordinator {

    /// Optional reference to the parent coordinator, allowing for a hierarchy of coordinators.
    var parentCoordinator: Coordinator? { get set }

    /// An array to hold child coordinators, enabling navigation between different flows in the app.
    var children: [Coordinator] { get set }

    /// A navigation controller to manage the navigation stack and transitions between view controllers.
    var navigationController: UINavigationController { get set }

    /// Method to start the coordinator's flow, typically used to present the initial view controller.
    func start()

}
