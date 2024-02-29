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

    var presenter: ProfilePresenter?

    // MARK: - Private Properties

    private let userName = "Anna Morgan"
    private let userImage = "avatar"
    private let userBonuses = 100

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

    private func configureProfileCell(for cell: ProfileTableViewCell) {
        cell.configureCell(imageName: userImage, userName: userName)
        cell.editButtonAction = { [weak self] in
            let alert = UIAlertController(title: Constants.alertTitle, message: nil, preferredStyle: .alert)

            alert.addTextField { textField in
                textField.placeholder = Constants.alertTextFieldPlaceholder
            }

            let okAction = UIAlertAction(title: Constants.alertOkText, style: .default) { [weak self] action in
                if let textField = alert.textFields?.first, let text = textField.text {
                    cell.configureCell(imageName: self?.userImage ?? "", userName: text)
                }
            }

            let cancelAction = UIAlertAction(title: Constants.alertCancelText, style: .cancel)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.preferredAction = okAction

            self?.present(alert, animated: true)
        }
    }

    private func configureButtonCell(for cell: ButtonTableViewCell) {
        cell.configureCell(bonuses: userBonuses)

        cell.bonusButtonAction = { [weak self] in
            let bottomSheet = BottomSheetViewController()
            bottomSheet.setBonuses(bonuses: self?.userBonuses ?? 0)
            if let sheet = bottomSheet.sheetPresentationController {
                sheet.detents = [.custom(resolver: { context in
                    355
                })]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 30
            }
            self?.present(bottomSheet, animated: true)
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
            configureProfileCell(for: cell)
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
