//
//  HTTPClient.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import Combine
import SwiftUI
import Foundation

protocol HTTPClient {
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error>
}

struct InvalidHTTPResponseError: Error { }

extension URLSession: HTTPClient {
    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), any Error> {
        return dataTaskPublisher(for: request)
            .tryMap({ result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw InvalidHTTPResponseError()
                }
                return (result.data, httpResponse)
            })
            .catch { error -> AnyPublisher<(Data, HTTPURLResponse), Error> in
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

class HTTPClientDecorator: HTTPClient {

    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        return self.client.publisher(request: request)
            .flatMap { data, response -> AnyPublisher<(Data, HTTPURLResponse), Error> in
                return Just((data, response)).setFailureType(to: Error.self).eraseToAnyPublisher()

            }
            .catch { error -> AnyPublisher<(Data, HTTPURLResponse), Error> in
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

struct GenericAPIHTTPRequestMapper {
    static func map<T>(data: Data, response: HTTPURLResponse) throws -> T where T: Decodable {
        if (200..<300) ~= response.statusCode {

            print("ℹ️ Response Data for decoding: \(String(data: data, encoding: .utf8) ?? "No Data")")
            if T.self == String.self,
               let stringResponse = String(data: data, encoding: .utf8) {
                return stringResponse as! T
            }

            if let urlString = String(data: data, encoding: .utf8),
               let url = URL(string: urlString), T.self == URL.self {
                return url as! T
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                return try decoder.decode(T.self, from: data)
            } catch {
                let decodingError = error as! DecodingError
                let detailedError = decodeErrorDetails(error: decodingError, data: data)
                print("❗️ Decoding Error: \(detailedError)")
                throw APIErrorHandler.decodingError(detailedError)
            }
        } else {
            if let error = try? JSONDecoder().decode(APIError.self, from: data) {
                throw APIErrorHandler.customApiError(error)
            } else {
                let rawResponse = String(data: data, encoding: .utf8) ?? "No Data"
                print("❗️ Unexpected Status Code: \(response.statusCode). Raw response: \(rawResponse)")
                throw APIErrorHandler.emptyErrorWithStatusCode("Status code: \(response.statusCode). Response: \(rawResponse)")
            }
        }
    }

    private static func decodeErrorDetails(error: DecodingError, data: Data) -> String {
        var errorMessage = "Decoding error: \(error.localizedDescription)\n"

        switch error {
        case .typeMismatch(let type, let context):
            errorMessage += "Type mismatch for type \(type): \(context.debugDescription)\n"
            errorMessage += "Coding Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))\n"
        case .valueNotFound(let type, let context):
            errorMessage += "Value not found for type \(type): \(context.debugDescription)\n"
            errorMessage += "Coding Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))\n"
        case .keyNotFound(let key, let context):
            errorMessage += "Key not found: \(key.stringValue): \(context.debugDescription)\n"
            errorMessage += "Coding Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))\n"
        case .dataCorrupted(let context):
            errorMessage += "Data corrupted: \(context.debugDescription)\n"
            errorMessage += "Coding Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))\n"
        @unknown default:
            errorMessage += "Unknown error: \(error)\n"
        }

        if let jsonString = String(data: data, encoding: .utf8) {
            errorMessage += "JSON Data: \(jsonString)\n"
        }

        return errorMessage
    }
}
