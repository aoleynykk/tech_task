//
//  DetailsPresenter.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

protocol DetailsPresentationLogic {
    func presentCharacterDetail(response: DetailsModel.Response)
}

class DetailsPresenter: DetailsPresentationLogic {
    func presentCharacterDetail(response: DetailsModel.Response) {
        
    }
    
    weak var viewController: DetailsDisplayLogic?
}
