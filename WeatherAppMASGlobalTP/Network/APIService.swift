//
//  APIService.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 03/10/24.
//

import Foundation

enum APIError: Error {
    case urlSessionError(String)
    case serverError(String = "Invalid API Key")
    case invalidResponse(String = "Invalid response from server.")
    case decodingError(String = "Error parsing server response.")
    case requestError
}

protocol Service {
    func makeRequest<T: Codable>(
        with request: URLRequest,
        respModel: T.Type,
        completion: @escaping (T?, APIError?) -> Void
    )
}

class APIService: Service {

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

    func makeRequest<T: Codable>(
        with request: URLRequest,
        respModel: T.Type,
        completion: @escaping (T?, APIError?) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, resp, error in
            if let error {
                completion(nil, .urlSessionError(error.localizedDescription))
                return
            }

            if let resp = resp as? HTTPURLResponse, resp.statusCode > 299 {
                completion(nil, .serverError())
                return
            }

            guard let data else {
                completion(nil, .invalidResponse())
                return
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result, nil)

            } catch let err {
                print(err)
                completion(nil, .decodingError())
                return
            }

        }.resume()
    }

}

extension APIService {

    func makeRequest(with request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                return data
            case 401:
                throw RequestError.unauthorised
            default:
                throw RequestError.unexpectedStatusCode
            }
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }

    func makeRequest(
        with request: URLRequest,
        shouldParseResponse: Bool = true,
        completion: @escaping ([String: Any]?, APIError?) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(nil, .urlSessionError(error.localizedDescription))
                return
            }

            if let response = response as? HTTPURLResponse, response.statusCode > 299 {
                completion(nil, .serverError())
                return
            }

            guard let data else {
                completion(nil, .invalidResponse())
                return
            }
            if shouldParseResponse {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(json, nil)
                    } else {
                        completion(nil, .decodingError())
                    }
                } catch {
                    completion(nil, .decodingError())
                    print("Error:", error)
                }
            } else {
                completion([:], nil)
            }

        }.resume()
    }
}
