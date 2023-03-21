//
//  NetworkService.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 13.02.2022.
//

import Foundation

final class NetworkService {

    // MARK: - Public

    func createBridgeToken(userId: String, product: Product) async throws -> BridgeTokenResponse? {
        let body = BridgeTokenRequest(product: product).toJSONData()
        guard let request = makeRequest(path: "/v1/users/\(userId)/tokens/", body: body) else { return nil }

        let session = URLSession.shared
        let (data, _) = try await session.data(for: request)
        guard
            let tokenResponse = try? JSONDecoder().decode(BridgeTokenResponse.self, from: data)
        else { return nil }
        
        return tokenResponse
    }
    
    func createUser(userId: String) async throws -> CreateUserResponse? {
        let body = CreateUserRequest(userId: userId).toJSONData()
        guard let request = makeRequest(path: "/v1/users/", body: body) else { return nil }
        
        let session = URLSession.shared
        let (data, _) = try await session.data(for: request)
        guard
            let createUserResponse = try? JSONDecoder().decode(CreateUserResponse.self, from: data)
        else { return nil }
        
        return createUserResponse
    }

    // MARK: - Private

    private func makeRequest(path: String, body: Data?) -> URLRequest? {
        guard let tokenUrl = URL(string:"\(Endpoint.apiHost)\(path)") else { return nil }

        var request = URLRequest(url: tokenUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let clientId = AppState.shared.settings.clientId.value {
            request.addValue(clientId, forHTTPHeaderField: "X-Access-Client-Id")
        }
        if let clientSecret = AppState.shared.settings.keyForSelectedEnvironment {
            request.addValue(clientSecret, forHTTPHeaderField: "X-Access-Secret")
        }
        
        request.httpBody = body

        return request
    }

}
