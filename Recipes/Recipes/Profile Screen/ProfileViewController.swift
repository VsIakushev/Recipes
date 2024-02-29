// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля
final class ProfileViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Profile"
        static let titleFont = UIFont(name: "Verdana-Bold", size: 28)
        static let alertTitle = "Change your name and surname"
        static let alertTextFieldPlaceholder = "Name Surname"
        static let alertOkText = "Ok"
        static let alertCancelText = "Cancel"
    }

    // MARK: - Visual Components

    private let tableView = UITableView()

    // MARK: - Public Properties

    var presenter: ProfilePresenterProtocol?

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupNavigation()
        setupTableView()
    }

    // MARK: - Private Methods

    private func setupNavigation() {
        let titleLabel = UILabel()
        titleLabel.font = Constants.titleFont
        titleLabel.text = Constants.titleText
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "ButtonCell")
    }

    private func showAlert(completion: @escaping StringHandler) {
        let alert = UIAlertController(title: Constants.alertTitle, message: nil, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = Constants.alertTextFieldPlaceholder
        }

        let okAction = UIAlertAction(title: Constants.alertOkText, style: .default) { _ in
            if let textField = alert.textFields?.first, let text = textField.text {
                completion(text)
            }
        }

        let cancelAction = UIAlertAction(title: Constants.alertCancelText, style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.preferredAction = okAction

        present(alert, animated: true)
    }

    private func configureButtonCell(for cell: ButtonTableViewCell) {
        cell.configureCell(bonuses: presenter?.profileInfo.bonuses ?? 0)

        cell.bonusButtonAction = { [weak self] in
            self?.presenter?.bonusButtonPressed()
        }
        cell.logoutButtonAction = {
            self.presenter?.onLogOut()
        }
    }

    @objc func onTapAction() {
        presenter?.onTap()
    }

    @objc func onTapLogOutAction() {
        presenter?.onLogOut()
    }
}

// MARK: - ProfileViewController+ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    func showEditAlert() {
        showAlert { [weak self] editedName in
            self?.presenter?.setName(newName: editedName)
        }
    }

    func updateView() {
        tableView.reloadData()
    }
}

/// ProfileViewController+UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {}

/// ProfileViewController+UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileTableViewCell
            else { return UITableViewCell() }
            print("creating 1st cell")

            guard let presenter = presenter else { return UITableViewCell() }
            cell.configureCell(info: presenter.profileInfo)
            cell.editButtonAction = { [weak self] in
                self?.presenter?.editTapped()
            }
            return cell

        } else {
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as? ButtonTableViewCell
            else { return UITableViewCell() }
            print("creating 2nd cell")
            configureButtonCell(for: cell)
            return cell
        }
    }
}
