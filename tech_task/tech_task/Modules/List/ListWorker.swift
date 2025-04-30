//
//  ListWorker.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import Foundation
import Combine

class ListWorker {
    private let service = CharactersService(httpClient: HTTPClientDecorator(client: URLSession.shared))

    func fetchCharacters(page: Int) -> AnyPublisher<CharactersResponseModel, Error> {
        return service.getCharacters(page: page)
    }
}
