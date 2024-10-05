//
//  UserDefaultsManager.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

class UserDefaultsManager: UserDefaultsManagerProtocol {

    static var shared = UserDefaultsManager()

    private init() {}

    /// Save any `Codable` data type to UserDefaults
    @MainActor
    func save(_ data: some Codable, forKey key: String) async {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    /// Load any `Codable` data type from UserDefaults
    func load<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        if let savedData = UserDefaults.standard.data(forKey: key) {
            if let decodedData = try? JSONDecoder().decode(type, from: savedData) {
                return decodedData
            }
        }
        return nil
    }
}
