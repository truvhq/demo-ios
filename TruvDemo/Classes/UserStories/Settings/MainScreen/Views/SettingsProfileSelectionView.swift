//
//  SettingsProfileSelectionView.swift
//  Truv Demo
//
//  Created by Иван Беркут on 11.02.2024.
//

import SwiftUI

struct SettingsProfileSelectionView: View {

    struct DataItem {
        let items: [ProfileSelectionView.DataItem]
        let addNewSettingsCallback: () -> Void
    }

    let dataItem: DataItem

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(
                    dataItem.items,
                    id: \.self,
                    content: { item in
                        ProfileSelectionView(dataItem: item)
                    }
                )
                makeAddNewView()
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }

    private func makeAddNewView() -> some View {
        Button(
            action: { dataItem.addNewSettingsCallback() },
            label: {
                ZStack {
                    Color(.tertiarySystemGroupedBackground)
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                        .padding(16)
                }
                .cornerRadius(10)
                .frame(maxWidth: 120)
            }
        )
    }

}
