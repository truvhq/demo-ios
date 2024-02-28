import WebKit
import TruvSDK

final class TruvScriptMessageHandler {

    static func handleTruvSDKEvent(event: TruvSDK.TruvEvent) {
        switch event {
            case .onClose:
                NotificationCenter.default.post(name: Notification.Name.Truv.log, object: nil, userInfo: [NotificationKeys.message.rawValue: "widget closed"])
                NotificationCenter.default.post(name: Notification.Name.Truv.closeWidget, object: nil)
            case .onError:
                NotificationCenter.default.post(name: Notification.Name.Truv.closeWidget, object: nil)
            case .onEvent(let payload):
                let jsonEncoder = JSONEncoder()
                jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
                if
                    let payload = payload,
                    let encodedObject = try? jsonEncoder.encode(payload),
                    let prettyPrinted = NSString(data: encodedObject, encoding: String.Encoding.utf8.rawValue) {
                    NotificationCenter.default.post(name: Notification.Name.Truv.log, object: nil, userInfo: [NotificationKeys.message.rawValue: prettyPrinted])
                }
            case .onLoad:
                NotificationCenter.default.post(name: Notification.Name.Truv.log, object: nil, userInfo: [NotificationKeys.message.rawValue: "widget opened"])
            case .onSuccess:
                NotificationCenter.default.post(name: Notification.Name.Truv.log, object: nil, userInfo: [NotificationKeys.message.rawValue: "widget succeeded"])
                NotificationCenter.default.post(name: Notification.Name.Truv.closeWidget, object: nil)
        }
    }

}
