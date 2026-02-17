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

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
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

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func didTapOpenOrderButton() {
        view.endEditing(true)

        guard
            let urlString = orderUrlTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !urlString.isEmpty
        else {
            showInvalidURLAlert()
            return
        }

        guard let url = URL(string: urlString), url.scheme != nil, url.host != nil else {
            showInvalidURLAlert()
            return
        }

        showWebView(url: url)
    }

    private func showWebView(url: URL) {
        let orderController = TruvOrderController(url: url)
        orderController.modalPresentationStyle = .fullScreen
        present(orderController, animated: true)
    }

    private func showInvalidURLAlert() {
        let alert = UIAlertController(
            title: L10n.invalidOrderUrlAlertTitle,
            message: L10n.invalidOrderUrlAlertMessage,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: L10n.invalidOrderUrlAlertButtonTitle, style: .default))
        present(alert, animated: true)
    }

}
