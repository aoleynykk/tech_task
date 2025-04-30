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
        return "api"
    }

    var path: String {
        switch self {
        case .getCharacters:
            return "character"
        case .getCharacter(let id):
            return "character/\(id)"
        }
    }

    var queryForCall: [URLQueryItem]? {
        switch self {
        case .getCharacters(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        default:
            return nil
        }
    }

    var method: APIHTTPMethod {
        return .GET
    }
}
