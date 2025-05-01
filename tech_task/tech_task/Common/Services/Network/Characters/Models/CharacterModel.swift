//
//  CharacterModel.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import Foundation

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: Date

    static var emptyCharacter: CharacterModel {
        return CharacterModel(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: Origin(name: "", url: ""), location: Location(name: "", url: ""), image: "", episode: [], url: "", created: Date.now)
    }
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct Location: Codable {
    let name: String
    let url: String
}

