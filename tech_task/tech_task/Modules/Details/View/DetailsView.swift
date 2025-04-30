//
//  DetailsView.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

class DetailsView: UIView {

    let backButton: UIButton = {
        let obj = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        obj.setImage(image, for: .normal)
        obj.tintColor = .white
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        obj.layer.cornerRadius = 20
        obj.clipsToBounds = true
        return obj
    }()

    private let imageView: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFill
        obj.clipsToBounds = true
        obj.layer.cornerRadius = 16
        obj.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let obj = UIActivityIndicatorView(style: .medium)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()

    private let infoStack: UIStackView = {
        let obj = UIStackView()
        obj.axis = .vertical
        obj.spacing = 8
        obj.alignment = .leading
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()

    private let paddedContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let rootStack: UIStackView = {
        let obj = UIStackView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()

    private var imageViewWidthConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateLayout(for: UIDevice.current.orientation)
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .white

        addSubview(rootStack)
        addSubview(backButton)

        rootStack.addArrangedSubview(imageView)
        imageView.addSubview(activityIndicator)
        rootStack.addArrangedSubview(paddedContainer)

        paddedContainer.addSubview(infoStack)

        rootStack.spacing = 32
        rootStack.distribution = .fill
        rootStack.alignment = .fill

        NSLayoutConstraint.activate([
            rootStack.topAnchor.constraint(equalTo: topAnchor),
            rootStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            rootStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),

            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),

            infoStack.topAnchor.constraint(equalTo: paddedContainer.topAnchor, constant: 16),
            infoStack.leadingAnchor.constraint(equalTo: paddedContainer.leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: paddedContainer.trailingAnchor, constant: -16),
            infoStack.bottomAnchor.constraint(lessThanOrEqualTo: paddedContainer.bottomAnchor, constant: -16),

            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }

    @objc private func orientationChanged() {
        updateLayout(for: UIDevice.current.orientation)
    }

    private func updateLayout(for orientation: UIDeviceOrientation) {
        if orientation.isLandscape {
            rootStack.axis = .horizontal
            imageView.contentMode = .scaleAspectFill
            imageViewWidthConstraint?.isActive = false
            imageViewWidthConstraint = imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
            imageViewWidthConstraint?.isActive = true
            imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        } else {
            rootStack.axis = .vertical
            imageView.contentMode = .scaleAspectFit
            imageViewWidthConstraint?.isActive = false
            imageViewWidthConstraint = imageView.widthAnchor.constraint(equalTo: widthAnchor)
            imageViewWidthConstraint?.isActive = true
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        }
        setNeedsLayout()
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
