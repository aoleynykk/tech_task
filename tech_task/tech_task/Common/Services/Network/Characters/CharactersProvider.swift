//
//  CharactersProvider.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import Foundation
import Foundation

enum CharactersProvider {
    case getCharacters(page: Int = 1)
    case getCharacter(id: Int)
}

extension CharactersProvider: ApiEndpoint {
    var baseURLString: String {
        return APIConstants.baseURL
    }

    var apiPath: String {
        return "users"
    }

    var separatorPath: String? {
        return nil
    }

    var path: String {
        switch self {
        case .getCharacters:
            return "character"
        case .getCharacter(let id):
            return "character/\(id)"
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var queryForCall: [URLQueryItem]? {
        switch self {
        case .getCharacters(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        default:
            return nil
        }
    }

    var params: [String : Any]? {
        return nil
    }

    var method: APIHTTPMethod {
        return .GET
    }

    var customDataBody: Data? {
        return nil
    }
}
