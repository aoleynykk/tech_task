//
//  DetailsInteractor.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

protocol DetailsBusinessLogic {
    func fetchCharacterDetail()
}

protocol DetailsDataStore {
    var character: CharacterModel? { get set }
}

class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {
    func fetchCharacterDetail() {
        
    }
    
    var presenter: DetailsPresentationLogic?
    var character: CharacterModel?
}
