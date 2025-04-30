//
//  ListModels.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

enum ListModel {
    struct Request {

    }

    struct Response {
        let characters: [CharacterModel]
    }

    struct ViewModel {
        struct DisplayedCharacter {
            let id: Int
            let name: String
            let species: String
        }
        let displayedCharacters: [DisplayedCharacter]
    }
}
