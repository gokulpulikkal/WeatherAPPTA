//
//  LoadState.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

/// Enum to represent the loading state of an asynchronous operation.
public enum LoadState<Success: Equatable & Sendable, Failure: Error>: Sendable {

    /// Represents the loading state where data is being fetched.
    case loading

    /// Represents a successful loading state, containing the fetched data.
    case success(Success)

    /// Represents a failure state, containing an error indicating what went wrong.
    case failure(Failure)
}

// MARK: - Equatable

/// Conformance to Equatable to allow comparison of LoadState instances.
extension LoadState: Equatable {
    public static func == (lhs: LoadState<Success, Failure>, rhs: LoadState<Success, Failure>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            true
        case let (.success(l), .success(r)):
            l == r
        case (.failure(_), .failure(_)):
            true
        default:
            false
        }
    }
}
