//
//  ProductType.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 07.02.2022.
//

import Foundation

enum ProductType {

    case employmentHistory
    case incomeAndEmployment
    case directDepositSwitch
    case paycheckLinkedLoan
    case employeeDirectory
    case payrollHistory

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
        case .payrollHistory:
            return "Payroll history"
        }
    }

    var avaliableSettings: Set<ProductSettingType> {
        switch self {
        case .directDepositSwitch, .paycheckLinkedLoan:
            return [.companyMappingId, .providerId, .depositValue, .routingNumber, .accountNumber, .bankName, .accountType]
        default:
            return [.companyMappingId, .providerId]
        }
    }

}
