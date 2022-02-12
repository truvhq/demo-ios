//
//  BridgeTokenResponse.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 13.02.2022.
//

import Foundation

struct BridgeTokenResponse: Decodable {

    let bridge_token: String
    let company_mapping_id: String
    let client_name: String
    let product_type: String
    let allowed_products: [String]

}
