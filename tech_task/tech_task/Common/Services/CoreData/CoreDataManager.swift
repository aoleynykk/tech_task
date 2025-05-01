//
//  CoreDataManager.swift
//  tech_task
//
//  Created by Alex Oliynyk on 01.05.2025.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CharacterModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData error: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return container.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save error: \(error)")
            }
        }
    }

    func save(character: CharacterModel) {
        let entity = CachedCharacter(context: context)
        entity.id = Int64(character.id)
        entity.name = character.name
        entity.status = character.status
        entity.species = character.species
        entity.type = character.type
        entity.gender = character.gender
        entity.originName = character.origin.name
        entity.originURL = character.origin.url
        entity.locationName = character.location.name
        entity.locationURL = character.location.url
        entity.image = character.image as NSString
        entity.episode = character.episode as NSArray
        entity.url = character.url
        entity.created = character.created
        saveContext()
    }

    func fetchCharacter(withId id: Int) -> CharacterModel? {
        let request: NSFetchRequest<CachedCharacter> = CachedCharacter.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        if let result = try? context.fetch(request).first {
            return result.toCharacterModel()
        }
        return nil
    }

    func fetchAllCharacters() -> [CharacterModel] {
        let request: NSFetchRequest<CachedCharacter> = CachedCharacter.fetchRequest()
        guard let results = try? context.fetch(request) else { return [] }
        return results.compactMap { $0.toCharacterModel() }
    }
}
