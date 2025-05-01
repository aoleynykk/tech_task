//
//  DetailsView.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

class DetailsView: UIView {

    let backButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let paddedContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let rootStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 32
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var imageAspectRatioConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let isPortrait = bounds.height > bounds.width
        rootStack.axis = isPortrait ? .vertical : .horizontal
    }

    private func setup() {
        backgroundColor = .white

        addSubview(rootStack)
        addSubview(backButton)

        rootStack.addArrangedSubview(imageContainer)
        rootStack.addArrangedSubview(paddedContainer)

        imageContainer.addSubview(imageView)
        imageView.addSubview(activityIndicator)
        paddedContainer.addSubview(infoStack)

        // Replace fixed height = width with constraint with priority
        let aspect = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        aspect.priority = .defaultHigh
        imageAspectRatioConstraint = aspect

        NSLayoutConstraint.activate([
            rootStack.topAnchor.constraint(equalTo: topAnchor),
            rootStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            rootStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),

            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),

            imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),

            aspect, // This one replaces fixed strict ratio

            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),

            infoStack.topAnchor.constraint(equalTo: paddedContainer.topAnchor, constant: 16),
            infoStack.leadingAnchor.constraint(equalTo: paddedContainer.leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: paddedContainer.trailingAnchor, constant: -16),
            infoStack.bottomAnchor.constraint(lessThanOrEqualTo: paddedContainer.bottomAnchor, constant: -16)
        ])
    }

    func configure(with character: CharacterModel) {
        imageView.loadImage(from: character.image, with: activityIndicator)
        infoStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let info: [(String, String)] = [
            ("Name", character.name),
            ("Status", character.status),
            ("Species", character.species),
            ("Gender", character.gender),
            ("Origin", character.origin.name),
            ("Location", character.location.name)
        ]

        info.forEach { key, value in
            let label = UILabel()
            label.font = .systemFont(ofSize: 18)
            label.textColor = .black
            label.textAlignment = .left
            label.numberOfLines = 0
            label.text = "\(key): \(value)"
            infoStack.addArrangedSubview(label)
        }
    }
}
