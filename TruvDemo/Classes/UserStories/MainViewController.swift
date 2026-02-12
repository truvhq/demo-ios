//
//  ViewController.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 23.01.2022.
//

import UIKit
import SwiftUI

final class MainViewController: UITabBarController {

    // MARK: - Properties

    private let bridgeProductController = BridgeProductViewController()
    private let orderProductController = OrderProductViewController()
    private let consoleController = ConsoleViewController()
    private let settingsController = SettingsHostingController()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .main
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .textGray
        tabBar.isTranslucent = false
        configureControllers()
    }

    // MARK: - Private

    private func configureControllers() {
        let bridgeTabBarItem = UITabBarItem(
            title: L10n.bridgeTitle,
            image: UIImage(named: "PlayButton"),
            selectedImage: nil
        )
        bridgeProductController.tabBarItem = bridgeTabBarItem

        let orderTabBarItem = UITabBarItem(
            title: L10n.orderTitle,
            image: UIImage(systemName: "doc.text"), // TODO - it is a little bit different from the others
            selectedImage: nil
        )
        orderProductController.tabBarItem = orderTabBarItem

        let consoleTabBarItem = UITabBarItem(
            title: L10n.consoleTitle,
            image: UIImage(named: "TerminalButton"),
            selectedImage: nil
        )
        consoleController.tabBarItem = consoleTabBarItem

        let settingsTabBarItem = UITabBarItem(
            title: L10n.settingsTitle,
            image: UIImage(named: "SettingsButton"),
            selectedImage: nil
        )
        settingsController.tabBarItem = settingsTabBarItem

        viewControllers = [
            UINavigationController(rootViewController: bridgeProductController),
            UINavigationController(rootViewController: orderProductController),
            UINavigationController(rootViewController: consoleController),
            UINavigationController(rootViewController: settingsController)
        ]
    }

}

