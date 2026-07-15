//
//  AppState.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 10.02.2022.
//

final class AppState {

    static let shared = AppState()

    private init() {}

    var product = Product()
    var settings: Settings {
        KeychainManager().retrieveSettings() ?? Settings()
    }

    var userId: String? {
        get {
            guard let user = user, user.contextKey == userContextKey else { return nil }
            return user.id
        }
        set {
            user = newValue.map { (id: $0, contextKey: userContextKey) }
        }
    }

    private var user: (id: String, contextKey: String)?

    private var userContextKey: String {
        let settings = self.settings
        return [
            settings.stand.apiUrl,
            settings.clientId.value ?? "",
            settings.keyForSelectedEnvironment ?? ""
        ].joined(separator: "|")
    }

}
