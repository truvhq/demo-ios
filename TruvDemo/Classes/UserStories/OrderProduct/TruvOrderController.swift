//
//  TruvOrderController.swift
//  TruvDemo
//

import UIKit
import TruvSDK

final class TruvOrderController: UIViewController {

    // MARK: - Properties

    private let url: URL

    // MARK: - Init

    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let orderView = TruvOrderView(url: url)
        orderView.translatesAutoresizingMaskIntoConstraints = false
//        orderView.onClose = { [weak self] in
//            self?.dismiss(animated: true)
//        }
        view.addSubview(orderView)

        NSLayoutConstraint.activate([
            orderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            orderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            orderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            orderView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}
