//
//  DetailsWorker.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import Foundation
import Combine

class DetailsWorker {
    private let service = CharactersService(httpClient: HTTPClientDecorator(client: URLSession.shared))

    func fetchCharacterDetails(id: Int) -> AnyPublisher<CharacterModel, Error> {
        return service.getCharacterDetails(id: id)
    }
}
