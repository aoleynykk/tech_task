//
//  ListViewTableViewCell.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

class ListViewTableViewCell: UITableViewCell, Reusable {

    var model: ListModel.ViewModel.DisplayedCharacter? {
        didSet {
            handleUI()
        }
    }

    private let containerView: UIView = {
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.layer.cornerRadius = 16
        obj.clipsToBounds = true
        obj.layer.borderWidth = 1
        obj.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        return obj
    }()

    private let characterImageView: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFit
        obj.clipsToBounds = true
        obj.layer.cornerRadius = 12
        return obj
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let obj = UIActivityIndicatorView(style: .medium)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()

    private let characterNameLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.textAlignment = .left
        obj.font = .systemFont(ofSize: 16, weight: .semibold)
        obj.textColor = .black
        return obj
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(characterImageView)
        characterImageView.addSubview(activityIndicator)
        containerView.addSubview(characterNameLabel)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            characterImageView.widthAnchor.constraint(equalToConstant: 48),
            characterImageView.heightAnchor.constraint(equalToConstant: 48),
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            characterImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            characterImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),

            activityIndicator.centerXAnchor.constraint(equalTo: characterImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor),

            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            characterNameLabel.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor),
            characterNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])

    }

    private func handleUI() {
        guard let model else { return }
        characterNameLabel.text = model.name
        characterImageView.loadImage(from: model.image, with: activityIndicator)
    }
}
