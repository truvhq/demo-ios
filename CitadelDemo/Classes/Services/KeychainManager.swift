//
//  KeychainManager.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 10.02.2022.
//

import Foundation

final class KeychainManager {

    // MARK: - Public

    func save(key: String, data: Data?) {
        guard let data = data else { return }

        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ] as [String: Any]

        SecItemDelete(query as CFDictionary)

        SecItemAdd(query as CFDictionary, nil)
    }

    func load(key: String) -> Data? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!, // swiftlint:disable:this force_unwrapping
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String: Any]

        var dataTypeRef: AnyObject?

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr, let data = dataTypeRef as? Data? {
            return data
        } else {
            return nil
        }
    }

}

extension Data {

    init<T>(from value: T) {
        var value = value
        var data = Data()
        withUnsafePointer(to:&value, { (ptr: UnsafePointer<T>) -> Void in
            data = Data( buffer: UnsafeBufferPointer(start: ptr, count: 1))
        })
        self.init(data)
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
