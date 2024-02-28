//
//  SettingsViewModel.swift
//  Truv Demo
//
//  Created by Иван Беркут on 11.02.2024.
//

import Combine
import Foundation

class SettingsViewModel: ObservableObject {

    @Published var selectionViewDataItem: SettingsProfileSelectionView.DataItem = .init(items: [], addNewSettingsCallback: {})
    var showAddSettingsScreen = PassthroughSubject<AddNewSettingsInputData, Never>()

    private let keychainManager = KeychainManager()

    init() {
        makeItems()
    }

    private func makeItems() {
        let selectedSettings = keychainManager.retrieveSettings() ?? AppState.shared.settings

        var settings = keychainManager.retrieveAllSettings()
        if settings.isEmpty {
            settings = [selectedSettings]
        }

        let settingsDataItems: [ProfileSelectionView.DataItem] = settings.map { setting in
            .init(
                settings: setting,
                isSelected: setting == selectedSettings,
                selectionCallback: { [weak self] in
                    self?.selectSettings(settings: setting)
                },
                editCallback: { [weak self] in
                    self?.editSettings(settings: setting)
                },
                deleteCallback: { [weak self] in
                    self?.deleteSettings(settings: setting)
                }
            )
        }

        selectionViewDataItem = .init(
            items: settingsDataItems,
            addNewSettingsCallback: { [weak self] in
                self?.addNewSettings()
            }
        )
    }

    private func addNewSettings() {
        let addNewSettingsInputData = AddNewSettingsInputData(
            settings: nil,
            updateCallback: { [weak self] in
                self?.makeItems()
            }
        )

        showAddSettingsScreen.send(addNewSettingsInputData)
    }

    private func selectSettings(settings: Settings) {
        keychainManager.saveSettings(settings)
        makeItems()
    }

    private func editSettings(settings: Settings) {
        let addNewSettingsInputData = AddNewSettingsInputData(
            settings: settings,
            updateCallback: { [weak self] in
                self?.selectNewItemIfNeeded()
                self?.makeItems()
            }
        )

        showAddSettingsScreen.send(addNewSettingsInputData)
    }

    private func deleteSettings(settings: Settings) {
        var otherSettings = keychainManager.retrieveAllSettings()

        if let index = otherSettings.firstIndex(where: { $0 == settings }) {
            otherSettings.remove(at: index)
        }

        keychainManager.saveSettingsArray(otherSettings)
        selectNewItemIfNeeded()
        makeItems()
    }

    private func selectNewItemIfNeeded() {
        let selectedSettings = keychainManager.retrieveSettings()
        let settings = keychainManager.retrieveAllSettings()

        if !settings.contains(where: { $0 == selectedSettings }) {
            if let firstSetting = settings.first {
                keychainManager.saveSettings(firstSetting)
            }
        }
    }

}
