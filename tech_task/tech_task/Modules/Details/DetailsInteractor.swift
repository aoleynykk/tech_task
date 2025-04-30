//
//  DetailsInteractor.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit
import Combine

protocol DetailsBusinessLogic {
    func fetchCharacterDetail()
}

protocol DetailsDataStore {
    var characterId: Int? { get set }
}

class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {

    var presenter: DetailsPresentationLogic?

    var characterId: Int?

    var worker: DetailsWorker?

    private var cancellables = Set<AnyCancellable>()

    func fetchCharacterDetail() {
        if let id = characterId {
            worker?.fetchCharacterDetails(id: id)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    if case .failure(let error) = completion {
                        print("❌ Error:", error)
                    }
                } receiveValue: { [weak self] response in
                    guard let self else { return }
                    let responseModel = DetailsModel.Response(character: response)
                    presenter?.presentCharacterDetails(response: responseModel)
                }
                .store(in: &cancellables)
        }
    }
}
