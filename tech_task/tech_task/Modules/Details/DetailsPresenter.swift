//
//  DetailsPresenter.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

protocol DetailsPresentationLogic {
    func presentCharacterDetails(response: DetailsModel.Response)
}

class DetailsPresenter: DetailsPresentationLogic {
    weak var viewController: DetailsDisplayLogic?

    func presentCharacterDetails(response: DetailsModel.Response) {
        let viewModel = DetailsModel.ViewModel(character: response.character)
        viewController?.displayCharacter(viewModel: viewModel)
    }
}
