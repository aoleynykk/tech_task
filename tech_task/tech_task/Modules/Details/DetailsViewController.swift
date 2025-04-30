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

    private let detailsView = DetailsView()

    override func loadView() {
        super.loadView()
        view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchCharacterDetail()
        detailsView.backButton.addTarget(self, action: #selector(didBackButtonTapped), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension DetailsViewController {
    @objc private func didBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailsViewController: DetailsDisplayLogic {
    func displayCharacter(viewModel: DetailsModel.ViewModel) {
        detailsView.configure(with: viewModel.character)
    }
}

