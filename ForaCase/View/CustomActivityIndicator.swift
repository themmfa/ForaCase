//
//  CustomActivityIndicator.swift
//  ForaCase
//
//  Created by F E on 14.12.2023.
//

import UIKit

class CustomActivityIndicator: UIViewController {
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.center = view.center
        activityIndicator.color = .white
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.addSubview(activityIndicator)
    }

    func startAnimating(in viewController: UIViewController) {
        modalPresentationStyle = .overFullScreen
        viewController.present(self, animated: false, completion: nil)
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
        dismiss(animated: false, completion: nil)
    }
}
