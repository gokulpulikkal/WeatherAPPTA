//
//  UserDefaultsManagerProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//

import Foundation

/// Protocol defining methods for managing user defaults with asynchronous save and load capabilities.
protocol UserDefaultsManagerProtocol: AnyObject {

    /// Asynchronously saves Codable data for a given key.
    @MainActor
    func save<T: Codable>(_ data: T, forKey key: String) async

    /// Loads Codable data for a given key.
    func load<T: Codable>(forKey key: String, as type: T.Type) -> T?
}

/// Mock implementation of UserDefaultsManagerProtocol for testing purposes.
class UserDefaultsManagerProtocolMock: UserDefaultsManagerProtocol {

    /// Closure for the save(_:forKey:) function, allowing custom behavior during tests.
    var saveResult: ((Any, String) async -> Void)?

    /// Sets the mock implementation for saving data.
    func setImplementationForSave<T: Codable>(function: @escaping (T, String) async -> Void) {
        saveResult = { data, key in
            if let castedData = data as? T {
                await function(castedData, key)
            }
        }
    }

    /// Mocked save method, conforming to UserDefaultsManagerProtocol.
    @MainActor
    func save(_ data: some Codable, forKey key: String) async {
        guard let saveResult else {
            return // No mock set, do nothing
        }
        await saveResult(data, key)
    }

    /// Closure for the load(forKey:as:) function, allowing custom behavior during tests.
    var loadResult: ((String) -> Any?)?

    /// Sets the mock implementation for loading data.
    func setImplementationForLoad(function: @escaping (String) -> (some Codable)?) {
        loadResult = { key in
            function(key)
        }
    }

    /// Mocked load method, conforming to UserDefaultsManagerProtocol.
    func load<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        guard let loadResult else {
            return nil // No mock set, return nil
        }
        return loadResult(key) as? T
    }

}
