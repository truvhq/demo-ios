//
//  Product.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 07.02.2022.
//

import Foundation

struct Product {

    var type: ProductType = .employmentHistory

    var settings = [
        ProductSetting(type: .companyMappingId, value: ""),
        ProductSetting(type: .providerId, value: ""),
        ProductSetting(type: .depositValue, value: "1"),
        ProductSetting(type: .routingNumber, value: "123456789"),
        ProductSetting(type: .accountNumber, value: "160025987"),
        ProductSetting(type: .bankName, value: "TD Bank"),
        ProductSetting(type: .accountType, value: "checking")
    ]

}
