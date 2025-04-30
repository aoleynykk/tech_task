//
//  ListRouter.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

@objc protocol ListRoutingLogic {
    func routeToCharacterDetail()
}

protocol ListDataPassing {
    var dataStore: ListDataStore? { get }
}

class ListRouter: NSObject, ListRoutingLogic, ListDataPassing {
    weak var viewController: ListViewController?
    var dataStore: ListDataStore?

    func routeToCharacterDetail() {
        let destinationVC = DetailsViewController()
        let destinationDS = DetailsInteractor()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        

        destinationVC.interactor = destinationDS
        destinationVC.router = router
        destinationDS.presenter = presenter
        destinationDS.worker = DetailsWorker()
        presenter.viewController = destinationVC
        router.viewController = destinationVC
        router.dataStore = destinationDS

        destinationDS.characterId = dataStore?.selectedCharacter?.id
        viewController?.navigationItem.backButtonTitle = ""
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
