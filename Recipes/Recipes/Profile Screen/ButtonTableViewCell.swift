// ButtonTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с кнопками в профиле пользователя
final class ButtonTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let bonusesButtonText = "Bonuses"
        static let bonusesButtonImage = "star"
        static let termsButtonText = "Terms & Privacy Policy"
        static let termsButtonImage = "terms"
        static let logoutButtonText = "Log out"
        static let logoutButtonImage = "logout"
    }

    // MARK: - Visual Components

    private let bonusesButton = ProfileButton()
    private let termsButton = ProfileButton()
    private let logoutButton = ProfileButton()

    // MARK: - Public Properties

    var bonusButtonAction: VoidHandler?
    var logoutButtonAction: VoidHandler?
    var termsAndPolicyButtonAction: VoidHandler?

    // MARK: - Private Properties

    private var userBonuses = 0

    // MARK: - Public Methods

    func configureCell(bonuses: Int) {
        userBonuses = bonuses
        addViews()
        setupUI()
        setConstraints()
    }

    // MARK: - Private Methods

    private func addViews() {
        contentView.addSubview(bonusesButton)
        contentView.addSubview(termsButton)
        contentView.addSubview(logoutButton)
    }

    private func setupUI() {
        bonusesButton.configure(image: UIImage(named: Constants.bonusesButtonImage), text: Constants.bonusesButtonText)
        termsButton.configure(image: UIImage(named: Constants.termsButtonImage), text: Constants.termsButtonText)
        logoutButton.configure(image: UIImage(named: Constants.logoutButtonImage), text: Constants.logoutButtonText)
        bonusesButton.addTarget(self, action: #selector(bonusesButtonPressed), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(termsButtonPressed), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
    }

    private func setConstraints() {
        bonusesButton.translatesAutoresizingMaskIntoConstraints = false
        termsButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 280),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),

            bonusesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            bonusesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            bonusesButton.topAnchor.constraint(equalTo: topAnchor),
            bonusesButton.heightAnchor.constraint(equalToConstant: 56),

            termsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            termsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            termsButton.heightAnchor.constraint(equalToConstant: 56),
            termsButton.topAnchor.constraint(equalTo: bonusesButton.bottomAnchor, constant: 25),

            logoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            logoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            logoutButton.heightAnchor.constraint(equalToConstant: 56),
            logoutButton.topAnchor.constraint(equalTo: termsButton.bottomAnchor, constant: 25)
        ])
    }

    @objc private func bonusesButtonPressed() {
        bonusButtonAction?()
    }

    // реализация в следующем задании
    @objc private func termsButtonPressed() {
        termsAndPolicyButtonAction?()
    }

    @objc private func logoutButtonPressed() {
        logoutButtonAction?()
    }
}
