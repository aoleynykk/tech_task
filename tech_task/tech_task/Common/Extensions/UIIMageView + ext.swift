//
//  UIIMageView + ext.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String, with activityIndicator: UIActivityIndicatorView? = nil) {
        guard let url = URL(string: urlString) else { return }

        activityIndicator?.startAnimating()
        self.image = nil

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()

                guard let data = data, let image = UIImage(data: data) else { return }
                self?.image = image
            }
        }.resume()
    }
}
