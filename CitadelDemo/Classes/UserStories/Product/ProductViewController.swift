//
//  ProductViewController.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 07.02.2022.
//

import UIKit

final class ProductViewController: UIViewController {

    // MARK: - Properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .main
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
        tableView.alwaysBounceVertical = false

        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()
    private lazy var openBridgeButton: UIButton = {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .accentGreen
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.setTitle(L10n.openBridgeButtonTitle, for: [])
        button.addTarget(self, action: #selector(didTapOpenBridgeButton), for: .touchUpInside)

        return button
    }()
    private var isSettingsExpanded = false
    private var picker: SettingsPickerView?

    private var product = Product()
    private var additionalSettingViewModels: [SettingsCellViewModel] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = L10n.productTitle

        setupSubviews()
        reload()
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
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])

        view.addSubview(openBridgeButton)
        NSLayoutConstraint.activate([
            openBridgeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            openBridgeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            openBridgeButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            openBridgeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            openBridgeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func didTapExpandButton() {
        isSettingsExpanded = !isSettingsExpanded
        reload()
    }

    private func showProductTypePicker(forRowAt index: IndexPath) {
        guard let cell = tableView.cellForRow(at: index) as? MenuTableViewCell else { return }

        picker = SettingsPickerView(data: ProductType.allCases.map { $0.title } )
        picker?.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        let pickerAccessory = UIToolbar()
        pickerAccessory.autoresizingMask = .flexibleHeight
        pickerAccessory.isTranslucent = false

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapPickerDoneButton))
        doneButton.tintColor = .accentGreen

        pickerAccessory.items = [flexibleSpace, doneButton]

        if let selectedIndex = ProductType.allCases.firstIndex(of: product.type) {
            picker?.selectRow(selectedIndex, inComponent: 0, animated: false)
        }
        cell.activationTextField.inputView = picker
        cell.activationTextField.inputAccessoryView = pickerAccessory
        cell.activationTextField.becomeFirstResponder()
    }

    @objc private func didTapPickerDoneButton() {
        if let value = picker?.selectedValue,
           let type = ProductType.allCases.first(where: { $0.title == value } ) {
            product.type = type
        }
        reload()
        view.endEditing(true)
    }

    @objc private func didTapOpenBridgeButton() {

    }

    private func reload() {
        additionalSettingViewModels = ProductViewModelsFactory.makeAdditionalSettingViewModels(from: product, isSettingsExpanded: isSettingsExpanded)
        tableView.reloadData()
    }

}

extension ProductViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            showProductTypePicker(forRowAt: indexPath)
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

        let title = isSettingsExpanded ? L10n.hideAdditionalSettings : L10n.showAdditionalSettings
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
            detail = product.type.title
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
