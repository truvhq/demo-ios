//
//  Settings.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 10.02.2022.
//

import Foundation

final class Settings: Codable, Hashable {

    var selectedEnvironment: Environment
    let clientId: ProductSetting
    let accessKeys: [ProductSetting]
    var keyName: String?
    var userId: String?
    var stand: Stand

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
        keyName = nil
    }

    var keyForSelectedEnvironment: String? {
        accessKeys.first(where: { $0.type == selectedEnvironment.productSettingsType })?.value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(selectedEnvironment)
        hasher.combine(clientId)
        hasher.combine(accessKeys)
        hasher.combine(userId)
        hasher.combine(stand)
        hasher.combine(keyName)
    }

    static func == (lhs: Settings, rhs: Settings) -> Bool {
        lhs.selectedEnvironment == rhs.selectedEnvironment &&
        lhs.clientId == rhs.clientId &&
        lhs.accessKeys == rhs.accessKeys &&
        lhs.userId == rhs.userId &&
        lhs.stand == rhs.stand &&
        lhs.keyName == rhs.keyName
    }

}
