//
//  ViewController.swift
//  TruvDemo
//
//  Created by Sergey Butorin on 23.01.2022.
//

import UIKit

final class MainViewController: UITabBarController {

    // MARK: - Properties

    private let productController = ProductViewController()
    private let consoleController = ConsoleViewController()
    private let settingsController = SettingsViewController()

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
        let productTabBarItem = UITabBarItem(
            title: L10n.productTitle,
            image: UIImage(named: "PlayButton"),
            selectedImage: nil
        )
        productController.tabBarItem = productTabBarItem

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
            UINavigationController(rootViewController: productController),
            UINavigationController(rootViewController: consoleController),
            UINavigationController(rootViewController: settingsController)
        ]
    }

}

