// ProfileTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка профиля пользователя
final class ProfileTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let title = "Profile"

        static let imageViewHeight: CGFloat = 160
        static let nameLabelWidth: CGFloat = 256
        static let nameLabelHeight: CGFloat = 30
        static let editButtonHeight: CGFloat = 18
        static let alertTitle = "Change your name and surname"
        static let alertTextFieldPlaceholder = "Name Surname"
        static let alertOkText = "Ok"
        static let alertCancelText = "Cancel"
    }

    // MARK: - Visual Components

    private let userImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let editButton = UIButton()

    // MARK: - Private Properties

    private var userName = ""
    private var userImage = ""

    // MARK: - Public Methods

    var editButtonAction: VoidHandler?

    func setName(newName: String) {
        userName = newName
    }

    func configureCell(info: ProfileInfo) {
        userName = info.username
        userImage = info.avatar
        addViews()
        setupUI()
        setConstraints()
    }

    // MARK: - Private Methods

    private func addViews() {
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(editButton)
    }

    private func setupUI() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false

        userImageView.image = UIImage(named: userImage)
        userImageView.layer.cornerRadius = 80
        userImageView.clipsToBounds = true

        userNameLabel.text = userName
        userNameLabel.font = UIFont.verdanaBold25()
        userNameLabel.textColor = UIColor.text02()
        userNameLabel.textAlignment = .center

        editButton.setImage(UIImage(named: "pencil"), for: .normal)
        editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        editButton.tintColor = UIColor.text02()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 280),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),

            userImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            userImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight),
            userImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewHeight),

            userNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 25),
            userNameLabel.widthAnchor.constraint(equalToConstant: Constants.nameLabelWidth),
            userNameLabel.heightAnchor.constraint(equalToConstant: Constants.nameLabelHeight),

            editButton.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            editButton.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 11),
            editButton.heightAnchor.constraint(equalToConstant: Constants.editButtonHeight),
            editButton.widthAnchor.constraint(equalToConstant: Constants.editButtonHeight),
        ])
    }

    @objc private func editButtonPressed() {
        editButtonAction?()
    }
}
