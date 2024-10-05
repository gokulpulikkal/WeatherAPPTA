//
//  EnvironmentValuesExtensions.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//

import SwiftUI

extension EnvironmentValues {

    /// Custom environment variable and it's default value
    @Entry var city = City(name: "Cupertino", state: "CA", country: "US")
}
