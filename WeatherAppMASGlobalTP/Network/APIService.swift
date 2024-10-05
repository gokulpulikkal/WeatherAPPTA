//
//  APIService.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

/// APIService class responsible for making network requests and handling API responses.
/// Should have extended from a protocol so that Testing would be possible
class APIService {

    /// Asynchronous method to make a network request and decode the response into a specified model.
    func makeRequest<T: Codable>(with request: URLRequest, respModel: T.Type) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
            case 401:
                throw RequestError.unauthorised
            default:
                throw RequestError.unexpectedStatusCode
            }
        } catch {
            print("The API service error \(error.localizedDescription)")
            throw error
        }
    }
}
