//
//  BrowserView.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 13.02.2022.
//

import UIKit
import WebKit

final class BrowserView: UIView, WKUIDelegate {

    // MARK: - Properties

    private let webView: WKWebView
    private let token: String

    // MARK: - Lifecycle

    init(token: String) {
        self.token = token

        let configuration = WKWebViewConfiguration()
        let handler = TruvScriptMessageHandler()
        configuration.userContentController.add(handler, name: "iosListener")
        webView = WKWebView(frame: .zero, configuration: configuration)

        super.init(frame: .zero)

        webView.uiDelegate = self
        webView.navigationDelegate = self
        setupLayout()
        startLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func startLoading() {
        guard let url = URL(string: "\(Endpoint.widgetUrl)/mobile.html?bridge_token=\(token)") else { return }
        let request = URLRequest(url: url)

        webView.load(request)
        let message = "Opening Widget with baseUrl: \(Endpoint.widgetUrl) and bridgeToken \(token)"
        NotificationCenter.default.post(name: Notification.Name.Truv.log, object: nil, userInfo: [NotificationKeys.message.rawValue: message])
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        guard let url = navigationAction.request.url else { return nil }
        UIApplication.shared.open(url)
        return nil
    }

}

// MARK: - WKNavigationDelegate

extension BrowserView: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url,
           !["cdn.truv.com", "citadel-resources.s3.us-west-2.amazonaws.com"].contains(url.host) {
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
            return
        }

        decisionHandler(.allow)
    }

}
