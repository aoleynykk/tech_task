//
//  CharactersService.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import Foundation
import Combine

class CharactersService {

    let httpClient: HTTPClientDecorator

    init(httpClient: HTTPClientDecorator) {
        self.httpClient = httpClient
    }

    func getCharacters(page: Int) -> AnyPublisher<CharactersResponseModel, Error> {
        return httpClient
            .publisher(request: CharactersProvider.getCharacters(page: page).makeRequest)
            .tryMap(GenericAPIHTTPRequestMapper.map)
            .eraseToAnyPublisher()
    }

    func getCharacterDetails(id: Int) -> AnyPublisher<CharacterModel, Error> {
        return httpClient
            .publisher(request: CharactersProvider.getCharacter(id: id).makeRequest)
            .tryMap(GenericAPIHTTPRequestMapper.map)
            .eraseToAnyPublisher()
    }
}
