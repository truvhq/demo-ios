//
//  ProfileSelectionView.swift
//  Truv Demo
//
//  Created by Иван Беркут on 12.02.2024.
//

import SwiftUI

struct ProfileSelectionView: View {

    let dataItem: DataItem

    var body: some View {
        Button(
            action: { dataItem.selectionCallback() },
            label: {
                ZStack {
                    Color(.tertiarySystemGroupedBackground)
                    HStack(alignment: .center) {
                        createEnvironmentImage()
                        createTextsView()
                        createButtonsView()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    createStrokeOverlay()
                }
                .cornerRadius(10)
                .frame(maxWidth: 250)
            }
        )
    }

    func createEnvironmentImage() -> some View {
        Image(systemName: dataItem.settings.selectedEnvironment.iconSystemName)
            .resizable()
            .foregroundColor(.black)
            .frame(width: 14, height: 14)
    }

    func createTextsView() -> some View {
        VStack(alignment: .leading) {
            Text(L10n.keyName)
                .foregroundColor(.gray)
                .font(.caption2)
            Text(dataItem.settings.keyName ?? L10n.empty)
                .foregroundColor(.black)
                .font(.caption)
                .padding(.bottom, 4)
            Text(L10n.clientId)
                .foregroundColor(.gray)
                .font(.caption2)
            Text(dataItem.settings.clientId.value ?? L10n.empty)
                .foregroundColor(.black)
                .font(.caption)
                .padding(.bottom, 4)
            Text(L10n.accessKey)
                .foregroundColor(.gray)
                .font(.caption2)
            Text(dataItem.settings.accessKeys.first?.value ?? L10n.empty)
                .foregroundColor(.black)
                .font(.caption)
        }
    }

    func createButtonsView() -> some View {
        VStack {
            createEditButton()
            createDeleteButton()
        }
        .padding(.leading, 16)
    }

    func createEditButton() -> some View {
        Button(
            action: { dataItem.editCallback() },
            label: {
                Image(systemName: "pencil")
                    .foregroundColor(.black)
                    .frame(width: 16, height: 16)
            }
        )
    }

    func createDeleteButton() -> some View {
        Button(
            action: { dataItem.deleteCallback() },
            label: {
                Image(systemName: "trash")
                    .foregroundColor(.black)
                    .frame(width: 16, height: 16)
            }
        )
    }

    func createStrokeOverlay() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color(dataItem.isSelected ? .accent : .clear), lineWidth: 2)
    }
}

extension ProfileSelectionView {

    struct DataItem: Hashable {
        let settings: Settings
        let isSelected: Bool
        let selectionCallback: () -> Void
        let editCallback: () -> Void
        let deleteCallback: () -> Void

        func hash(into hasher: inout Hasher) {
            hasher.combine(settings)
            hasher.combine(isSelected)
        }

        static func == (lhs: ProfileSelectionView.DataItem, rhs: ProfileSelectionView.DataItem) -> Bool {
            lhs.settings == rhs.settings &&
            lhs.isSelected == rhs.isSelected
        }
    }

}

extension Environment {

    var iconSystemName: String {
        switch self {
            case .sandbox:
                "s.circle"
            case .development:
                "d.circle"
            case .production:
                "p.circle"
        }
    }
}
