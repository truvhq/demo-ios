//
//  Product.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 07.02.2022.
//

import Foundation

final class Product {

    var type: ProductType = .employeeDirectory

    let settings = [
        ProductSetting(type: .companyMappingId),
        ProductSetting(type: .providerId),
        ProductSetting(type: .depositValue, value: "1"),
        ProductSetting(type: .routingNumber, value: "123456789"),
        ProductSetting(type: .accountNumber, value: "160025987"),
        ProductSetting(type: .bankName, value: "TD Bank"),
        ProductSetting(type: .bankAddress, value: "address"),
        ProductSetting(type: .accountType, value: "checking"),
        ProductSetting(type: .depositType, value: "amount")
    ]

}
