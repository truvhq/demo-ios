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

enum Stand: CaseIterable, Codable {
    case development
    case stage
    case production
    
    var apiUrl: String {
        switch self {
        case .production:
            return "https://prod.truv.com"
        case .stage:
            return "https://stage.truv.com"
        case .development:
            return "https://dev.truv.com"
        }
    }
    
    var cdnUrl: String {
        switch self {
        case .production:
            return "https://cdn.truv.com"
        case .stage:
            return "https://cdn-stage.truv.com"
        case .development:
            return "https://cdn-dev.truv.com"
        }
    }
    
    var title: String {
        switch self {
        case .production:
            return "Production"
        case .stage:
            return "Stage"
        case .development:
            return "Development"
        }
    }
}
