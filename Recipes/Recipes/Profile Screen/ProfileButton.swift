// ProfileButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомная кнопка для страницы Профиля
final class ProfileButton: UIButton {

    // MARK: - Visual Components

    private let buttonView = UIButton()
    private let imageBackgroundView = UIView()
    private let buttonImageView = UIImageView()
    private let label = UILabel()
    private let chevronImageView = UIImageView()
    private let underlineView = UIView()

    // MARK: - Public Methods

    func configure(image: UIImage?, text: String?) {
        buttonImageView.image = image
        label.text = text
        addViews()
        setupUI()
        setConstraints()
    }

    // MARK: - Private Methods

    private func addViews() {
        addSubview(buttonView)
        buttonView.addSubview(imageBackgroundView)
        imageBackgroundView.addSubview(buttonImageView)
        buttonView.addSubview(chevronImageView)
        buttonView.addSubview(underlineView)
    }

    private func setupUI() {
        buttonView.isUserInteractionEnabled = false

        imageBackgroundView.backgroundColor = UIColor.background04()
        imageBackgroundView.layer.cornerRadius = 12
        imageBackgroundView.isUserInteractionEnabled = false

        buttonImageView.contentMode = .scaleAspectFit
        buttonImageView.isUserInteractionEnabled = false

        label.textAlignment = .center
        label.textAlignment = .left
        label.textColor = UIColor.text02()
        buttonImageView.isUserInteractionEnabled = false
        buttonView.addSubview(label)

        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.image = UIImage(systemName: "chevron.forward")
        chevronImageView.tintColor = UIColor.text02()
        buttonImageView.isUserInteractionEnabled = false

        underlineView.backgroundColor = UIColor.divider02()
    }

    private func setConstraints() {
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        imageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        buttonImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonView.widthAnchor.constraint(equalToConstant: 325),
            buttonView.heightAnchor.constraint(equalToConstant: 56),

            imageBackgroundView.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            imageBackgroundView.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: 48),
            imageBackgroundView.widthAnchor.constraint(equalToConstant: 48),

            buttonImageView.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor),
            buttonImageView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            buttonImageView.heightAnchor.constraint(equalToConstant: 23),
            buttonImageView.widthAnchor.constraint(equalToConstant: 23),

            label.leadingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 225),
            label.heightAnchor.constraint(equalToConstant: 24),

            chevronImageView.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            chevronImageView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            chevronImageView.heightAnchor.constraint(equalToConstant: 24),
            chevronImageView.widthAnchor.constraint(equalToConstant: 24),

            underlineView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -11),
            underlineView.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
