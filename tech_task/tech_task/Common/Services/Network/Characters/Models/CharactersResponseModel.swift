//
//  CharactersResponseModel.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import Foundation

struct CharactersResponseModel: Codable {
    let info: PageInfo
    let results: [CharacterModel]
}
