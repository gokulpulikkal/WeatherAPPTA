//
//  UserDefaultsManager.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 04/10/24.
//

import Foundation

/// Class responsible for managing UserDefaults with methods for saving and loading Codable data.
class UserDefaultsManager: UserDefaultsManagerProtocol {

    /// Singleton instance of UserDefaultsManager for shared access.
    static var shared = UserDefaultsManager()

    /// Private initializer to enforce singleton usage.
    private init() {}

    /// Asynchronously saves any `Codable` data type to UserDefaults.
    /// - Parameters:
    ///   - data: The `Codable` data to be saved.
    ///   - key: The key under which the data will be stored in UserDefaults.
    @MainActor
    func save(_ data: some Codable, forKey key: String) async {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    /// Loads any `Codable` data type from UserDefaults.
    /// - Parameters:
    ///   - key: The key associated with the data in UserDefaults.
    ///   - type: The type to which the data will be decoded.
    /// - Returns: An optional instance of the specified type, or nil if loading fails.
    func load<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        if let savedData = UserDefaults.standard.data(forKey: key) {
            if let decodedData = try? JSONDecoder().decode(type, from: savedData) {
                return decodedData
            }
        }
        return nil
    }
}
