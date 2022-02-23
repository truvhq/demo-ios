import WebKit

final class CitadelScriptMessageHandler: NSObject, WKScriptMessageHandler {

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard
            let body = message.body as? [String: Any],
            let eventName = body["event"] as? String,
            let name = WebViewMessageHandlers(rawValue: eventName)
        else { return }

        switch name {
        case .onClose:
            NotificationCenter.default.post(name: Notification.Name.Citadel.log, object: nil, userInfo: [NotificationKeys.message.rawValue: "widget closed"])
            NotificationCenter.default.post(name: Notification.Name.Citadel.closeWidget, object: nil)
        case .onError:
            NotificationCenter.default.post(name: Notification.Name.Citadel.closeWidget, object: nil)
        case .onEvent:
            if
                let body = message.body as? [String: Any],
                let payload = body["payload"],
                let data = try? JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted),
                let prettyPrinted = String(data: data, encoding: .utf8) {
                NotificationCenter.default.post(name: Notification.Name.Citadel.log, object: nil, userInfo: [NotificationKeys.message.rawValue: prettyPrinted])
            }
        case .onLoad:
            NotificationCenter.default.post(name: Notification.Name.Citadel.log, object: nil, userInfo: [NotificationKeys.message.rawValue: "widget opened"])
        case .onSuccess:
            NotificationCenter.default.post(name: Notification.Name.Citadel.log, object: nil, userInfo: [NotificationKeys.message.rawValue: "widget succeeded"])
            NotificationCenter.default.post(name: Notification.Name.Citadel.closeWidget, object: nil)
        }

    }

}

enum WebViewMessageHandlers: String {

    case onClose
    case onError
    case onEvent
    case onLoad
    case onSuccess

}
