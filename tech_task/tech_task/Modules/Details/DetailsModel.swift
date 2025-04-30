//
//  DetailsModel.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

enum DetailsModel {
    struct Request { }

    struct Response {
        let character: CharacterModel
    }

    struct ViewModel {
        let character: CharacterModel
    }
}
