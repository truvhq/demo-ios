//
//  SettingsHostingController.swift
//  Truv Demo
//
//  Created by Иван Беркут on 12.02.2024.
//

import UIKit
import SwiftUI
import Combine

class SettingsHostingController: UIViewController {

    // MARK: - Private Properties
    private var viewModel: SettingsViewModel = SettingsViewModel()
    private var cancellables = Set<AnyCancellable>()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        addView()
        bindings()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = L10n.settingsTitle
    }

    // MARK: - Private Methods
    private func bindings() {
        viewModel.showAddSettingsScreen
            .sink { [weak self] inputData in
                self?.showAddSettingsScreen(inputData: inputData)
            }
            .store(in: &cancellables)
    }

    private func addView() {
        let contentView = SettingsView(viewModel: viewModel)
        let controller = UIHostingController(rootView: contentView)
        addChild(controller)
        view.addSubview(controller.view)
        view.backgroundColor = .white
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.didMove(toParent: self)

        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func showAddSettingsScreen(inputData: AddNewSettingsInputData) {
        let controller = AddNewSettingHostingController(inputData: inputData)
        let navigationController = UINavigationController(rootViewController: controller)
        present(navigationController, animated: true)
    }
}
