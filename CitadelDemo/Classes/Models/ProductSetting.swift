//
//  ProductSetting.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 09.02.2022.
//

import Foundation

struct ProductSetting {

    let type: ProductSettingType
    var value: String

}

enum ProductSettingType {

    case companyMappingId
    case providerId
    case depositValue
    case routingNumber
    case accountNumber
    case bankName
    case accountType

    var title: String {
        switch self {
        case .companyMappingId:
            return "Company Mapping ID"
        case .providerId:
            return "Provider ID"
        case .depositValue:
            return "Deposit Value"
        case .routingNumber:
            return "Routing Number"
        case .accountNumber:
            return "Account Number"
        case .bankName:
            return "Bank Name"
        case .accountType:
            return "Account type"
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

}
