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

    private let token: String

    // MARK: - Lifecycle

    init(token: String) {
        self.token = token

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

        guard let url = URL(string: Endpoint.widgetUrl) else { return }
        let request = URLRequest(url: url)

        webView.load(request)
    }
}
