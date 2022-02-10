//
//  ProductViewModelsFactory.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 08.02.2022.
//

import Foundation

enum ProductViewModelsFactory {

    static func makeAdditionalSettingViewModels(from product: Product, isSettingsExpanded: Bool) -> [SettingsCellViewModel] {
        guard isSettingsExpanded else { return [] }
        
        var viewModels: [SettingsCellViewModel] = []

        for setting in product.settings where product.type.avaliableSettings.contains(setting.type) {
            viewModels.append(SettingsCellViewModel(title: setting.type.title, value: setting.value))
        }

        return viewModels
    }

}
