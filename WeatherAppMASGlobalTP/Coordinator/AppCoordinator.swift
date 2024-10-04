//
//  AppCoordinator.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation
import UIKit
import SwiftUI

class AppCoordinator: Coordinator {

    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }

    func start() {
//        navigationController.pushViewController(UIHostingController(rootView: WeatherHomeScreen()), animated: true)
        navigationController.pushViewController(UIHostingController(rootView: CitySearchView()), animated: true)
    }

}
