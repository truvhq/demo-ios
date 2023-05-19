//
//  Settings.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 10.02.2022.
//

import Foundation

final class Settings: Codable {

    var selectedEnvironment: Environment
    let clientId: ProductSetting
    let accessKeys: [ProductSetting]
    var userId: String?;
    var stand: Stand;

    init() {
        selectedEnvironment = .sandbox
        clientId = ProductSetting(type: .clientId)
        accessKeys = [
            ProductSetting(type: .sandboxEnvironment),
            ProductSetting(type: .developmentEnvironment),
            ProductSetting(type: .productionEnvironment)
        ]
        stand  = Stand.production
        userId = nil
    }

    var keyForSelectedEnvironment: String? {
        return accessKeys.first(where: { $0.type == selectedEnvironment.productSettingsType })?.value
    }

}
