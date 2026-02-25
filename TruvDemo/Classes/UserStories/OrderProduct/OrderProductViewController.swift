//
//  OrderProductViewController.swift
//  TruvDemo
//

import UIKit
import TruvSDK

final class OrderProductViewController: UIViewController {
    // MARK: - Properties

    private lazy var orderTokenTextField: UITextField = {
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
        view.addSubview(orderTokenTextField)
        NSLayoutConstraint.activate([
            orderTokenTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            orderTokenTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            orderTokenTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            orderTokenTextField.heightAnchor.constraint(equalToConstant: 44)
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

    @objc private func closeWebView() {
        dismiss(animated: true)
    }

    @objc private func didTapOpenOrderButton() {
        view.endEditing(true)

        guard
            let orderBridgeToken = orderTokenTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !orderBridgeToken.isEmpty
        else {
            showInvalidTokenAlert()
            return
        }

        showWebView(token: orderBridgeToken)
    }

    private func showWebView(token: String) {
        let truvBridgeController = TruvBridgeController.order(
            token: token,
            delegate: self,
            config: .init(
                cdnURL: AppState.shared.settings.stand.cdnUrl,
                apiURL: AppState.shared.settings.stand.apiUrl,
                orderURL: AppState.shared.settings.stand.orderUrl,
                isDebug: true
            )
        )
        truvBridgeController.modalPresentationStyle = .fullScreen

        present(truvBridgeController, animated: true)
    }

    private func showInvalidTokenAlert() {
        let alert = UIAlertController(
            title: L10n.invalidOrderBridgeTokenAlertTitle,
            message: L10n.invalidOrderBridgeTokenAlertMessage,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: L10n.invalidOrderBridgeTokenAlertButtonTitle, style: .default))
        present(alert, animated: true)
    }
}

extension OrderProductViewController: TruvOrderDelegate {

    func onEvent(_ event: TruvSDK.TruvOrderEvent) {
        if case .widgetEvent(let eventPayload) = event {
            TruvScriptMessageHandler.handleTruvSDKEventOnEvent(event: eventPayload)
        }
        
        TruvScriptMessageHandler.handleTruvSDKOrderEvent(event: event)
        if case .close = event {
            dismiss(animated: true)
        }
    }

}
