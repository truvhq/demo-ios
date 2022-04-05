//
//  Environment.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 10.02.2022.
//

import Foundation

enum Environment: CaseIterable, Codable {

    case sandbox
    case development
    case production

    var title: String {
        switch self {
        case .sandbox:
            return L10n.sandbox
        case .development:
            return L10n.development
        case .production:
            return L10n.production
        }
    }

    var productSettingsType: ProductSettingType {
        switch self {
        case .sandbox:
            return .sandboxEnvironment
        case .development:
            return .developmentEnvironment
        case .production:
            return .productionEnvironment
        }
    }

}
