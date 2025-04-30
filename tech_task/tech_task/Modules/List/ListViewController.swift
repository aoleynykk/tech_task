//
//  ListViewController.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

protocol ListDisplayLogic: AnyObject {
    func displayCharacters(viewModel: ListModel.ViewModel)
}

class ListViewController: UIViewController {
    var interactor: ListBusinessLogic?
    var router: (NSObjectProtocol & ListRoutingLogic & ListDataPassing)?
}
