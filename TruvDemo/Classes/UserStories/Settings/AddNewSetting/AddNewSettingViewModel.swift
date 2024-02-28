//
//  AddNewSettingsViewModel.swift
//  Truv Demo
//
//  Created by Иван Беркут on 12.02.2024.
//

import Combine

class AddNewSettingViewModel: ObservableObject {

    @Published var selectedEnvironment: Environment = .production
    @Published var selectedStand: Stand = .production
    @Published var cliendId: String = ""
    @Published var accessKey: String = ""
    @Published var buttonTitle: String = L10n.addNewConfigurationTitle
    var updatePublisher = PassthroughSubject<Void, Never>()

    private let keychainManager = KeychainManager()
    private let inputData: AddNewSettingsInputData

    init(inputData: AddNewSettingsInputData) {
        self.inputData = inputData

        configureButtonTitle()
        configureExistingSettingsIfNeeded()
    }

    private func configureButtonTitle() {
        buttonTitle = inputData.settings == nil
            ? L10n.addNewConfigurationTitle
            : L10n.editConfigurationTitle
    }

    private func configureExistingSettingsIfNeeded() {
        guard let settings = inputData.settings else {
            return
        }

        selectedEnvironment = settings.selectedEnvironment
        selectedStand = settings.stand
        cliendId = settings.clientId.value ?? ""
        accessKey = settings.accessKeys.first?.value ?? ""
    }

    func saveConfiguration() {
        if let settings = inputData.settings {
            saveExistingSettings(existingSettings: settings)
            return
        }

        let settings = Settings()
        settings.selectedEnvironment = selectedEnvironment
        settings.stand = selectedStand
        if !cliendId.isEmpty {
            settings.clientId.value = cliendId
        }
        if !accessKey.isEmpty {
            settings.accessKeys.forEach { $0.value = accessKey }
        }

        var otherSettings = keychainManager.retrieveAllSettings()
        otherSettings.insert(settings, at: 0)

        keychainManager.saveSettingsArray(otherSettings)
        updatePublisher.send()
    }

    private func saveExistingSettings(existingSettings: Settings) {
        var settings = keychainManager.retrieveAllSettings()
        let selectedSettings = keychainManager.retrieveSettings() ?? AppState.shared.settings

        let newSettings = Settings()
        newSettings.selectedEnvironment = selectedEnvironment
        newSettings.stand = selectedStand
        if !cliendId.isEmpty {
            newSettings.clientId.value = cliendId
        }
        if !accessKey.isEmpty {
            newSettings.accessKeys.forEach { $0.value = accessKey }
        }

        if let index = settings.firstIndex(where: { $0 == existingSettings}) {
            settings[index] = newSettings
            keychainManager.saveSettingsArray(settings)
        }

        if existingSettings == selectedSettings {
            keychainManager.saveSettings(newSettings)
        }

        updatePublisher.send()
    }
}
