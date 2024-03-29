//
//  ProductSetting.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 09.02.2022.
//

import Foundation

final class ProductSetting: Codable, Hashable {

    let type: ProductSettingType
    var value: String?

    init(type: ProductSettingType, value: String? = nil) {
        self.type = type
        self.value = value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(value)
    }

    static func == (lhs: ProductSetting, rhs: ProductSetting) -> Bool {
        lhs.type == rhs.type &&
        lhs.value == rhs.value
    }

}

enum ProductSettingType: Codable, Hashable {

    // Product

    case companyMappingId
    case providerId
    case depositValue
    case routingNumber
    case accountNumber
    case bankName
    case bankAddress
    case accountType
    case depositType

    // Settings

    case clientId

    case sandboxEnvironment
    case developmentEnvironment
    case productionEnvironment

    var title: String {
        switch self {
        case .companyMappingId:
            return L10n.companyMappingId
        case .providerId:
            return L10n.providerId
        case .depositValue:
            return L10n.depositValue
        case .routingNumber:
            return L10n.routingNumber
        case .accountNumber:
            return L10n.accountNumber
        case .bankName:
            return L10n.bankName
        case .bankAddress:
            return L10n.bankAddress
        case .accountType:
            return L10n.accountType
        case .depositType:
            return L10n.depositType
        case .clientId:
            return L10n.clientId
        case .sandboxEnvironment:
            return L10n.sandbox
        case .developmentEnvironment:
            return L10n.development
        case .productionEnvironment:
            return L10n.production
        }
    }

    var hint: String {
        switch self {
        case .companyMappingId:
            return """
            Use the company mapping ID to skip the employer search step. For example, use IDs below:

            Facebook
            539aad839b51435aa8e525fed95f1688

            Kroger
            3f45aed287064cbc91d28eff0424a72a

            Fannie Mae
            4af9336b89294bc98879b1e38e6c72df
            """
        case .providerId:
            return "Use the provider ID to skip selecting a payroll provider. For example, use adp."
        default:
            return ""
        }
    }

    var tappableParams: [String] {
        switch self {
        case .companyMappingId:
            return [
                "539aad839b51435aa8e525fed95f1688",
                "3f45aed287064cbc91d28eff0424a72a",
                "4af9336b89294bc98879b1e38e6c72df"
            ]
        case .providerId:
            return ["adp"]
        default:
            return []
        }
    }

    var isNumericInput: Bool {
        self == .depositValue || self == .routingNumber || self == .accountNumber
    }

}
