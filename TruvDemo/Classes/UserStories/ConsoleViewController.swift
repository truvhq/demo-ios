//
//  ConsoleViewController.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 07.02.2022.
//

import UIKit

final class ConsoleViewController: UIViewController {

    // MARK: - Properties

    private lazy var logsTextView: UITextView = {
        let textView = UITextView()

        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 17)
        textView.backgroundColor = .main
        textView.textContainerInset.left = 16
        textView.textContainerInset.right = 16

        return textView
    }()
    private var emptyStateStackView: UIStackView?

    private var text = "" {
        didSet {
            logsTextView.text = text
        }
    }

    // MARK: - Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(addLogs(_:)), name: Notification.Name.Truv.log, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = L10n.consoleTitle
        view.backgroundColor = .main

        navigationController?.navigationBar.prefersLargeTitles = true

        setupLayout()
        if text.isEmpty {
            setupEmptyLogsState()
        } else {
            logsTextView.text = text
        }
    }

    // MARK: - Public

    @objc func addLogs(_ notification: NSNotification) {
        guard let message = notification.userInfo?[NotificationKeys.message.rawValue] as? String else { return }
        emptyStateStackView?.isHidden = true

        if !text.isEmpty {
            text.append("\n\n")
        }
        text.append(message)
    }

    // MARK: - Private

    private func setupLayout() {
        view.addSubview(logsTextView)
        NSLayoutConstraint.activate([
            logsTextView.topAnchor.constraint(equalTo: view.topAnchor),
            logsTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            logsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupEmptyLogsState() {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = L10n.emptyConsoleTitle

        let button = UIButton()
        button.setTitleColor(.accent, for: [])
        button.setTitle(L10n.emptyConsoleButtonTitle, for: [])
        button.addTarget(self, action: #selector(openProductPage), for: .touchUpInside)

        let stackView = UIStackView()
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        emptyStateStackView = stackView
    }

    @objc private func openProductPage() {
        tabBarController?.selectedIndex = 0
    }

}
