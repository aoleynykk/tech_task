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
            .handleEvents(receiveOutput: { response in
                response.results.forEach { CoreDataManager.shared.save(character: $0) }
            })
            .eraseToAnyPublisher()
    }

    func getCharacterDetails(id: Int) -> AnyPublisher<CharacterModel, Error> {
        return httpClient
            .publisher(request: CharactersProvider.getCharacter(id: id).makeRequest)
            .tryMap(GenericAPIHTTPRequestMapper.map)
            .handleEvents(receiveOutput: { character in
                CoreDataManager.shared.save(character: character)
            })
            .eraseToAnyPublisher()
    }

    func getCachedCharactersResponse() -> CharactersResponseModel {
         let cached = CoreDataManager.shared.fetchAllCharacters()
         let pageInfo = PageInfo(count: cached.count, pages: 1, next: nil, prev: nil)
         return CharactersResponseModel(info: pageInfo, results: cached)
     }

    func getCachedCharacter(id: Int) -> CharacterModel? {
        return CoreDataManager.shared.fetchCharacter(withId: id)
    }
} 
