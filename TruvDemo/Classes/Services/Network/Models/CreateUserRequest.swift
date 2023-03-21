//
//  CreateUserRequest.swift
//  Truv Demo
//
//  Created by Dmitrii Dorofeev on 21.02.23.
//

import Foundation

struct CreateUserRequest: Encodable {

    let external_user_id: String

    init(userId: String) {
        self.external_user_id = userId
    }

}
