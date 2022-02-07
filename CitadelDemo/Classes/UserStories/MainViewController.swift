//
//  ViewController.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 23.01.2022.
//

import UIKit

final class MainViewController: UITabBarController {

    // MARK: - Properties

    private lazy var productController = ProductViewController()
    private lazy var consoleController = ConsoleViewController()
    private lazy var settingsController = SettingsViewController()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainColor
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .textGrayColor
        configureControllers()
    }

    // MARK: - Private

    private func configureControllers() {
        let productTabBarItem = UITabBarItem(title: "Product", image: UIImage(named: "PlayButton"), selectedImage: nil)
        productController.tabBarItem = productTabBarItem

        let consoleTabBarItem = UITabBarItem(title: "Console", image: UIImage(named: "TerminalButton"), selectedImage: nil)
        consoleController.tabBarItem = consoleTabBarItem

        let settingsTabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "SettingsButton"), selectedImage: nil)
        settingsController.tabBarItem = settingsTabBarItem

        viewControllers = [productController, consoleController, settingsController]
    }

}

