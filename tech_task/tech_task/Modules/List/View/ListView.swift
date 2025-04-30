//
//  ListView.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

class ListView: UIView {
    let tableView: UITableView = {
        let obj = UITableView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.rowHeight = UITableView.automaticDimension
        obj.backgroundColor = .clear
        obj.separatorStyle = .none
        obj.showsVerticalScrollIndicator = false
        return obj
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white

        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
