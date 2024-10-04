//
//  CoordinatorProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation
import UIKit

protocol Coordinator {

    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()

}
