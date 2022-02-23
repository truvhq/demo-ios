//
//  Notification+Additions.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 17.02.2022.
//

import Foundation

extension Notification.Name {

    enum Citadel {
        static let log = Notification.Name("Citadel.log")
        static let closeWidget = Notification.Name("Citadel.closeWidget")
    }

}

enum NotificationKeys: String {

    case message

}
