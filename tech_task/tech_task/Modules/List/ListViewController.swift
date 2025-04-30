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

    private let listView = ListView()
    var interactor: ListBusinessLogic?
    var router: (NSObjectProtocol & ListRoutingLogic & ListDataPassing)?

    private var characters: [ListModel.ViewModel.DisplayedCharacter] = []

    override func loadView() {
        super.loadView()
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        interactor?.fetchCharacters()
    }

    private func initViewController() {
        self.title = "Characters"
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.tableView.prefetchDataSource = self
        listView.tableView.registerReusableCell(ListViewTableViewCell.self)
    }
}

extension ListViewController: ListDisplayLogic {
    func displayCharacters(viewModel: ListModel.ViewModel) {
        characters.append(contentsOf: viewModel.displayedCharacters)

        listView.tableView.performBatchUpdates {
            listView.tableView.insertRows(at: viewModel.insertedIndexPaths, with: .automatic)
        }
    }

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = characters[indexPath.row]
        let cell = tableView.dequeueReusableCell(for: indexPath) as ListViewTableViewCell
        cell.model = model
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.selectCharacter(at: indexPath.row)
        router?.routeToCharacterDetail()
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { $0.row >= characters.count - 1 }) {
            interactor?.fetchCharacters()
        }
    }
}
