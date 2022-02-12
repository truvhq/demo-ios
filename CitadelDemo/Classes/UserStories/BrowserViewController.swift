//
//  BrowserViewController.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 12.02.2022.
//

import UIKit
import WebKit

final class BrowserViewController: UIViewController, WKUIDelegate {

    // MARK: - Properties

    var webView: WKWebView!

    private let accessKey: String
    private let product: Product

    // MARK: - Lifecycle

    init(accessKey: String, product: Product) {
        self.accessKey = accessKey
        self.product = product

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let tokenUrl = URL(string:"\(Endpoint.apiHost)/v1/bridge-tokens/") else { return }
        var request = URLRequest(url: tokenUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(AppState.shared.settings.clientId.value, forHTTPHeaderField: "X-Access-Client-Id")
        request.addValue(accessKey, forHTTPHeaderField: "X-Access-Secret")
        request.httpBody = BridgeTokenRequestBody(product: product).toJSONData()
        webView.load(request)
    }
}
