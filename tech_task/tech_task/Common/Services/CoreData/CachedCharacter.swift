//
//  CachedCharacter.swift
//  tech_task
//
//  Created by Alex Oliynyk on 01.05.2025.
//

import Foundation
import CoreData

extension CachedCharacter {
    func toCharacterModel() -> CharacterModel {
        return CharacterModel(
            id: Int(id),
            name: name ?? "",
            status: status ?? "",
            species: species ?? "",
            type: type ?? "",
            gender: gender ?? "",
            origin: Origin(name: originName ?? "", url: originURL ?? ""),
            location: Location(name: locationName ?? "", url: locationURL ?? ""),
            image: image as? String ?? "",
            episode: episode as? [String] ?? [],
            url: url ?? "",
            created: created ?? Date()
        )
    }
}
