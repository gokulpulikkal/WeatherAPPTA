//
//  UserDefaultsManagerTests.swift
//  WeatherAppMASGlobalTPTests
//
//  Created by Gokul P on 05/10/24.
//

import Testing
@testable import WeatherAppMASGlobalTP

struct UserDefaultsManagerTests {

    let userDefaultsManager = UserDefaultsManagerProtocolMock()

    @Test
    func userDefaultsSaveTest() async {
        var userDefaultsDict = [String: City]()
        userDefaultsManager.setImplementationForSave { (data: City, key: String) async in
            userDefaultsDict[key] = data
        }

        userDefaultsManager.setImplementationForLoad { (key: String) -> City? in
            if key == Constants.UserDefaultKeys.savedCity.rawValue {
                return userDefaultsDict[key]
            }
            return nil
        }
        let savingCity = City(name: "Buffalo", state: "NY", country: "US")
        await userDefaultsManager.save(savingCity, forKey: Constants.UserDefaultKeys.savedCity.rawValue)

        #expect(
            userDefaultsManager
                .load(forKey: Constants.UserDefaultKeys.savedCity.rawValue, as: City.self) == savingCity
        )
    }

}
