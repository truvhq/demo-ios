//
//  OrderProductViewController.swift
//  TruvDemo
//

import UIKit

final class OrderProductViewController: UIViewController {

    // MARK: - Properties

    private lazy var orderUrlTextField: UITextField = {
        let textField = UITextField()

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = L10n.orderUrlPlaceholder
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 17)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .URL

        return textField
    }()

    private lazy var openOrderButton: UIButton = {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .accent
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.setTitle(L10n.openOrderButtonTitle, for: [])
        button.addTarget(self, action: #selector(didTapOpenOrderButton), for: .touchUpInside)

        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = L10n.orderTitle
        view.backgroundColor = .main
        navigationController?.navigationBar.prefersLargeTitles = true
        setupSubviews()
    }

    // MARK: - Private

    private func setupSubviews() {
        view.addSubview(orderUrlTextField)
        NSLayoutConstraint.activate([
            orderUrlTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            orderUrlTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            orderUrlTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            orderUrlTextField.heightAnchor.constraint(equalToConstant: 44)
        ])

        view.addSubview(openOrderButton)
        NSLayoutConstraint.activate([
            openOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            openOrderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            openOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            openOrderButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func didTapOpenOrderButton() {
        // TODO: Implement order opening
    }

}
