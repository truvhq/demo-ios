//
//  NetworkService.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 13.02.2022.
//

import Foundation

enum NetworkError: Error {
    case unexpectedResponse(statusCode: Int?, body: String)
}

final class NetworkService {

    // MARK: - Public

    func createBridgeToken(userId: String, product: Product) async throws -> BridgeTokenResponse? {
        let body = BridgeTokenRequest(product: product).toJSONData()
        guard let request = makeRequest(path: "/v1/users/\(userId)/tokens/", body: body) else { return nil }

        let session = URLSession.shared
        let (data, response) = try await session.data(for: request)

        guard
            let tokenResponse = try? JSONDecoder().decode(BridgeTokenResponse.self, from: data)
        else {
            throw NetworkError.unexpectedResponse(
                statusCode: (response as? HTTPURLResponse)?.statusCode,
                body: String(data: data, encoding: .utf8) ?? ""
            )
        }

        return tokenResponse
    }
    
    func createUser(userId: String) async throws -> CreateUserResponse? {
        let body = CreateUserRequest(userId: userId).toJSONData()
        guard let request = makeRequest(path: "/v1/users/", body: body) else { return nil }
        
        let session = URLSession.shared
        let (data, response) = try await session.data(for: request)
        guard
            let createUserResponse = try? JSONDecoder().decode(CreateUserResponse.self, from: data)
        else {
            throw NetworkError.unexpectedResponse(
                statusCode: (response as? HTTPURLResponse)?.statusCode,
                body: String(data: data, encoding: .utf8) ?? ""
            )
        }

        return createUserResponse
    }

    // MARK: - Private

    private func makeRequest(path: String, body: Data?) -> URLRequest? {
        guard let tokenUrl = URL(string:"\(AppState.shared.settings.stand.apiUrl)\(path)") else { return nil }

        let clientId = AppState.shared.settings.clientId.value
        let clientSecret = AppState.shared.settings.keyForSelectedEnvironment

        var request = URLRequest(url: tokenUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let clientId = clientId {
            request.addValue(clientId, forHTTPHeaderField: "X-Access-Client-Id")
        }
        if let clientSecret = clientSecret {
            request.addValue(clientSecret, forHTTPHeaderField: "X-Access-Secret")
        }

        request.httpBody = body

        let message = "Starting request \(tokenUrl.absoluteString) with clientId \(formatCredential(clientId)) and secret \(formatCredential(clientSecret))"
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name.Truv.log, object: nil, userInfo: [NotificationKeys.message.rawValue: message])
        }

        return request
    }

    private func formatCredential(_ value: String?) -> String {
        guard let value = value else { return "nil" }

        let visible: String
        if let dashIndex = value.firstIndex(of: "-") {
            let fourAfterDash = value[value.index(after: dashIndex)...].prefix(4)
            visible = String(value[...dashIndex] + fourAfterDash)
        } else {
            visible = String(value.prefix(4))
        }
        return "\"\(visible)***\""
    }

}
