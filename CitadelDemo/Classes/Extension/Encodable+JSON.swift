//
//  Encodable+JSON.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 13.02.2022.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
