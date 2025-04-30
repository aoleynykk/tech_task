//
//  ListPresenter.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

protocol ListPresentationLogic {
    func presentCharacters(response: ListModel.Response)
}

class ListPresenter: ListPresentationLogic {
    weak var viewController: ListDisplayLogic?

    func presentCharacters(response: ListModel.Response) {
        let newViewModels = response.newItems.map {
            ListModel.ViewModel.DisplayedCharacter(
                id: $0.id,
                name: $0.name,
                image: $0.image
            )
        }

        let insertedIndexPaths = (response.oldCount..<(response.oldCount + newViewModels.count))
            .map { IndexPath(row: $0, section: 0) }

        let viewModel = ListModel.ViewModel(
            displayedCharacters: newViewModels,
            insertedIndexPaths: insertedIndexPaths
        )

        viewController?.displayCharacters(viewModel: viewModel)
    }

}
