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
    func presentCharacters(response: ListModel.Response) {

    }
    
    weak var viewController: ListViewController?
}

