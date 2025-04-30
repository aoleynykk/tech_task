//
//  DetailsViewController.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

protocol DetailsDisplayLogic: AnyObject {
    func displayCharacter(viewModel: DetailsModel.ViewModel)
}

class DetailsViewController: UIViewController {
    var interactor: DetailsBusinessLogic?
    var router: (NSObjectProtocol & DetailsRoutingLogic & DetailsDataPassing)?
}
