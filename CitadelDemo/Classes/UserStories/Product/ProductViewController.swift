//
//  ProductViewController.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 07.02.2022.
//

import UIKit

final class ProductViewController: UIViewController {

    // MARK: - Properties

    private let tableView = UITableView()
    private var isSettingsExpanded = false

    private var product = Product()
    private var additionalSettingViewModels: [SettingsCellViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Product"

        setupSubviews()
        setupTableView()
        additionalSettingViewModels = ProductViewModelsFactory.makeAdditionalSettingViewModels(from: product, isSettingsExpanded: isSettingsExpanded)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: - Private

    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupTableView() {
        tableView.backgroundColor = .main
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
        tableView.alwaysBounceVertical = false

        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc private func didTapExpandButton() {
        isSettingsExpanded = !isSettingsExpanded
        additionalSettingViewModels = ProductViewModelsFactory.makeAdditionalSettingViewModels(from: product, isSettingsExpanded: isSettingsExpanded)
    }

    private func showProductTypePicker() {
        
    }

}

extension ProductViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            showProductTypePicker()
        } else {
            navigationController?.pushViewController(EditSettingViewController(setting: product.settings[indexPath.row]), animated: true)
        }
    }

}

extension ProductViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }

        return additionalSettingViewModels.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 1 else { return nil }

        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        let button = UIButton(frame: CGRect(x: 16, y: 0, width: tableView.frame.width, height: 20))

        let title = isSettingsExpanded ? "Hide additional settings" : "Show additional settings"
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.setTitle(title, for: [])
        button.setTitleColor(.accentGreen, for: [])
        button.addTarget(self, action: #selector(didTapExpandButton), for: .touchUpInside)

        view.addSubview(button)
        return view
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier) as? MenuTableViewCell
        else { return MenuTableViewCell() }

        let title: String
        let detail: String?
        if indexPath.section == 0 {
            title = "Product type"
            detail = product.type?.title
        } else {
            title = additionalSettingViewModels[indexPath.row].title
            detail = additionalSettingViewModels[indexPath.row].value
        }
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = detail

        if detail?.isEmpty == false {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }

}

private extension ProductViewController {

    enum Constants {
        static let cellReuseIdentifier = "ProductViewCellReuseIdentifier"
    }

}
