//
//  AppState.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 10.02.2022.
//

final class AppState {

    static let shared = AppState()

    private init() {}

    var product = Product()
    var settings = Settings()

}
