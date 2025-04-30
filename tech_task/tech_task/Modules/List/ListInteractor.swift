//
//  ListInteractor.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit
import Combine

protocol ListBusinessLogic {
    func fetchCharacters()
    func selectCharacter(at index: Int)
}

protocol ListDataStore {
    var characters: [CharacterModel] { get set }
    var selectedCharacter: CharacterModel? { get set }
}

class ListInteractor: ListBusinessLogic, ListDataStore {

    var selectedCharacter: CharacterModel?
    var presenter: ListPresentationLogic?
    var worker: ListWorker?

    private var cancellables = Set<AnyCancellable>()
    private var currentPage: Int = 1
    private var canLoadMore = true
    private var isLoading = false

    var characters: [CharacterModel] = []

    func fetchCharacters() {
        guard canLoadMore, !isLoading else { return }
        isLoading = true

        worker?.fetchCharacters(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("❌ Error:", error)
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }

                let oldCount = characters.count
                characters.append(contentsOf: response.results)
                canLoadMore = response.info.next != nil
                currentPage += 1

                let responseModel = ListModel.Response(
                    characters: characters,
                    newItems: response.results,
                    oldCount: oldCount
                )
                presenter?.presentCharacters(response: responseModel)
            }
            .store(in: &cancellables)
    }

    func selectCharacter(at index: Int) {
        guard index < characters.count else { return }
        selectedCharacter = characters[index]
    }
}
