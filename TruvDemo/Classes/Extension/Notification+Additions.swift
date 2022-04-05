//
//  Notification+Additions.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 17.02.2022.
//

import Foundation

extension Notification.Name {

    enum Truv {
        static let log = Notification.Name("Truv.log")
        static let closeWidget = Notification.Name("Truv.closeWidget")
    }

}

enum NotificationKeys: String {

    case message

}
