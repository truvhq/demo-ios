//
//  SettingsView.swift
//  Truv Demo
//
//  Created by Иван Беркут on 11.02.2024.
//

import SwiftUI

struct SettingsView: View {

    @ObservedObject var viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                makeConfigurationsTitleView()
                makeSelectionView()
            }
        }
    }

    private func makeConfigurationsTitleView() -> some View {
        Text(L10n.configurations)
            .font(.headline)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
    }

    private func makeSelectionView() -> some View {
        SettingsProfileSelectionView(dataItem: viewModel.selectionViewDataItem)
            .animation(.easeIn, value: viewModel.selectionViewDataItem.items)
    }
}
