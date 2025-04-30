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
    func routeToCharacterDetail() {
        
    }
    
    weak var viewController: ListViewController?
    var dataStore: ListDataStore?
}
