//
//  ProductType.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 07.02.2022.
//

import Foundation

enum ProductType: CaseIterable {

    case employmentHistory
    case incomeAndEmployment
    case directDepositSwitch
    case paycheckLinkedLoan
    case employeeDirectory
    case transactions
    case assets
    case insurance

    var title: String {
        switch self {
        case .employmentHistory:
            return "Employment history"
        case .incomeAndEmployment:
            return "Income and employment"
        case .directDepositSwitch:
            return "Direct deposit switch"
        case .paycheckLinkedLoan:
            return "Paycheck Linked Loan"
        case .employeeDirectory:
            return "Employee directory"
        case .transactions:
            return "Transactions"
        case .assets:
            return "Assets"
        case .insurance:
            return "Insurance"
        }
    }

    var hasAdditionalSettings: Bool {
        switch self {
        case .directDepositSwitch, .paycheckLinkedLoan:
            return true
        default:
            return false
        }
    }

    var avaliableSettings: Set<ProductSettingType> {
        if hasAdditionalSettings {
            return [
                .companyMappingId,
                .providerId,
                .depositValue,
                .routingNumber,
                .accountNumber,
                .bankName,
                .bankAddress,
                .accountType
            ]
        } else {
            return [
                .companyMappingId,
                .providerId,
                .bankAddress
            ]
        }
    }

    var requestValue: String {
        switch self {
        case .employmentHistory:
            return "employment"
        case .incomeAndEmployment:
            return "income"
        case .directDepositSwitch:
            return "deposit_switch"
        case .paycheckLinkedLoan:
            return "pll"
        case .employeeDirectory:
            return "admin"
        case .transactions:
            return "transactions"
        case .assets:
            return "assets"
        case .insurance:
            return "insurance"
        }
    }

}
