//
//  APIEndpoint.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import Foundation

enum APIHTTPMethod: String {
    case GET
//    case POST
//    case PUT
//    case DELETE
//    case PATCH
}

protocol ApiEndpoint {
    var baseURLString: String { get }
    var apiPath: String { get }
    var queryForCall: [URLQueryItem]? { get }
    var params: [String: Any]? { get }
    var method: APIHTTPMethod { get }
}

extension ApiEndpoint {
    var makeRequest: URLRequest {
        var urlComponents = URLComponents(string: baseURLString)
        var longPath = "/"
        longPath.append(apiPath)

        urlComponents?.path = longPath

        if let queryForCalls = queryForCall {
            urlComponents?.queryItems = [URLQueryItem]()
            for queryForCall in queryForCalls {
                urlComponents?.queryItems?.append(URLQueryItem(name: queryForCall.name, value: queryForCall.value))
            }
        }
        guard let url = urlComponents?.url else { return URLRequest(url: URL(string: baseURLString)!) }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let params = params {
            let paramsData = try? JSONSerialization.data(withJSONObject: params)
            request.httpBody = paramsData
        }

        print("--------->" + "\(request.url)")
        return request
    }
}

