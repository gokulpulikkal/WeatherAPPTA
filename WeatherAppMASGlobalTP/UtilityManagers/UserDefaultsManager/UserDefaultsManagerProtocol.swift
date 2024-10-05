//
//  UserDefaultsManagerProtocol.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//

import Foundation

protocol UserDefaultsManagerProtocol: AnyObject {
    @MainActor
    func save<T: Codable>(_ data: T, forKey key: String) async
    func load<T: Codable>(forKey key: String, as type: T.Type) -> T?
}

class UserDefaultsManagerProtocolMock: UserDefaultsManagerProtocol {

    /// Closure for save(_:forKey:) function
    var saveResult: ((Any, String) async -> Void)?

    /// Set the mock implementation for saving
    func setImplementationForSave<T: Codable>(function: @escaping (T, String) async -> Void) {
        saveResult = { data, key in
            if let castedData = data as? T {
                await function(castedData, key)
            }
        }
    }

    /// Mocked save method
    @MainActor
    func save(_ data: some Codable, forKey key: String) async {
        guard let saveResult else {
            return // No mock set, do nothing
        }
        await saveResult(data, key)
    }

    /// Closure for load(forKey:as:) function
    var loadResult: ((String) -> Any?)?

    /// Set the mock implementation for loading
    func setImplementationForLoad(function: @escaping (String) -> (some Codable)?) {
        loadResult = { key in
            function(key)
        }
    }

    /// Mocked load method
    func load<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        guard let loadResult else {
            return nil // No mock set, return nil
        }
        return loadResult(key) as? T
    }

}
