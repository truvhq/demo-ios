//
//  AddNewSettingsHostingController.swift
//  Truv Demo
//
//  Created by Иван Беркут on 12.02.2024.
//

import UIKit
import SwiftUI
import Combine

struct AddNewSettingsInputData {
    let settings: Settings?
    let updateCallback: () -> Void
}

class AddNewSettingHostingController: UIViewController {

    // MARK: - Private Properties
    private var viewModel: AddNewSettingViewModel
    private var cancellables = Set<AnyCancellable>()
    private let inputData: AddNewSettingsInputData

    init(inputData: AddNewSettingsInputData) {
        self.inputData = inputData
        self.viewModel = .init(inputData: inputData)
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
        title = inputData.settings == nil
            ? L10n.addNewConfigurationTitle
            : L10n.editConfigurationTitle
    }

    // MARK: - Private Methods
    private func bindings() {
        viewModel.updatePublisher
            .sink { [weak self] in
                self?.inputData.updateCallback()
                self?.dismiss(animated: true)
            }
            .store(in: &cancellables)
    }

    private func addView() {
        let contentView = AddNewSettingView(viewModel: viewModel)
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
}

