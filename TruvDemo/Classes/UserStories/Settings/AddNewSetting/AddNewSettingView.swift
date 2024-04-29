//
//  AddNewSettingView.swift
//  Truv Demo
//
//  Created by Иван Беркут on 12.02.2024.
//

import SwiftUI

struct AddNewSettingView: View {

    @ObservedObject var viewModel: AddNewSettingViewModel

    init(viewModel: AddNewSettingViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            createEnvironmentView()
            createStandView()
            createCliendIdView()
            createAccessKeyView()
            createNameView()

            Spacer()

            createSaveButtonView()
        }
        .padding(.horizontal, 16)
    }

    private func createEnvironmentView() -> some View {
        VStack(alignment: .leading) {
            Text(L10n.environment)
                .font(.headline)
                .padding(.vertical, 8)
            Picker("", selection: $viewModel.selectedEnvironment) {
                ForEach(Array(Environment.allCases.enumerated()), id: \.element, content: {
                    Text($0.element.title).tag($0.offset)
                })
            }
            .pickerStyle(.segmented)
        }
    }

    private func createStandView() -> some View {
        VStack(alignment: .leading) {
            Text(L10n.stand)
                .font(.headline)
                .padding(.vertical, 8)
            Picker("", selection: $viewModel.selectedStand) {
                ForEach(Array(Stand.allCases.enumerated()), id: \.element, content: {
                        Text($0.element.title).tag($0.offset)
                })
            }
                .pickerStyle(.segmented)
        }
    }

    private func createCliendIdView() -> some View {
        VStack(alignment: .leading) {
            Text(L10n.clientId)
                .font(.headline)
                .padding(.vertical, 8)
            TextField(
                L10n.clientId,
                text: $viewModel.cliendId,
                onEditingChanged: { _ in },
                onCommit: { }
            )
        }
    }

    private func createAccessKeyView() -> some View {
        VStack(alignment: .leading) {
            Text(L10n.accessKey)
                .font(.headline)
                .padding(.vertical, 8)
            TextField(
                L10n.accessKey,
                text: $viewModel.accessKey,
                onEditingChanged: { _ in },
                onCommit: { }
            )
        }
    }

    private func createNameView() -> some View {
        VStack(alignment: .leading) {
            Text(L10n.keyName)
                .font(.headline)
                .padding(.vertical, 8)
            TextField(
                L10n.keyName,
                text: $viewModel.keyName,
                onEditingChanged: { _ in },
                onCommit: { }
            )
        }
    }

    private func createSaveButtonView() -> some View {
        Button(
            action: { viewModel.saveConfiguration() },
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(.accent))
                    Text(viewModel.buttonTitle)
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.vertical, 8)
                }
                .frame(height: 50)
            }
        )
    }
}
