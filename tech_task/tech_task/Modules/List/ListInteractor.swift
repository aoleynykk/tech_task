//
//  ListInteractor.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

protocol ListBusinessLogic {
    func fetchCharacters()
    func selectCharacter(at index: Int)
}

protocol ListDataStore {
    var characters: [CharacterModel] { get set }
    var selectedCharacter: CharacterModel? { get set }
}

class ListInteractor: ListBusinessLogic, ListDataStore {
    func fetchCharacters() {

    }
    
    func selectCharacter(at index: Int) {
        
    }
    
    var presenter: ListPresentationLogic?
    var worker: ListWorker?
    var characters: [CharacterModel] = []
    var selectedCharacter: CharacterModel?
}
