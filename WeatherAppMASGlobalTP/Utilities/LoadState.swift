//
//  LoadState.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//


/// A value that represents either a success, failure, or intermediary loading state.
public enum LoadState<Success: Equatable & Sendable, Failure: Error>: Sendable {
    /// The state of loading.
    case loading

    /// A success, storing a success value.
    case success(Success)

    /// A failure, storing an error.
    case failure(Failure)
}

// MARK: - Equatable

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