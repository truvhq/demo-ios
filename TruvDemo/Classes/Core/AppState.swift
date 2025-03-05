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
    var userId: String? = nil
    var settings: Settings {
        KeychainManager().retrieveSettings() ?? Settings()
    }

}
