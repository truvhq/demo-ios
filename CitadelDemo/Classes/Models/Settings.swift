//
//  Settings.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 10.02.2022.
//

import Foundation

final class Settings {

    var selectedEnvironment: Environment
    let clientId: ProductSetting
    let accessKeys: [ProductSetting]

    init() {
        selectedEnvironment = .sandbox
        clientId = ProductSetting(type: .clientId)
        accessKeys = [
            ProductSetting(type: .sandboxEnvironment),
            ProductSetting(type: .developmentEnvironment),
            ProductSetting(type: .productionEnvironment)
        ]
    }

    var keyForSelectedEnvironment: String? {
        return accessKeys.first(where: { $0.type == selectedEnvironment.productSettingsType })?.value
    }

}
