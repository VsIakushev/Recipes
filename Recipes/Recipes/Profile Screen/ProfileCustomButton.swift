// ProfileCustomButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомная кнопка для страницы Профиля
final class ProfileCustomButton: UIButton {
    // MARK: - Visual Components

    private let buttonView = UIButton()
    private let imageBackground = UIView()
    private let buttonImageView = UIImageView()
    private let label = UILabel()
    private let chevronImageView = UIImageView()
    private let underline = UIView()

    // MARK: - Public Methods

    func configure(image: UIImage?, text: String?) {
        buttonImageView.image = image
        label.text = text
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        addSubview(buttonView)
        buttonView.addSubview(imageBackground)
        buttonView.isUserInteractionEnabled = false

        imageBackground.backgroundColor = UIColor(named: "background04")
        imageBackground.layer.cornerRadius = 12
        imageBackground.isUserInteractionEnabled = false

        buttonImageView.contentMode = .scaleAspectFit
        buttonImageView.isUserInteractionEnabled = false
        imageBackground.addSubview(buttonImageView)

        label.textAlignment = .center
        label.textAlignment = .left
        label.textColor = UIColor(named: "text02")
        buttonImageView.isUserInteractionEnabled = false
        buttonView.addSubview(label)

        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.image = UIImage(systemName: "chevron.forward")
        chevronImageView.tintColor = UIColor(named: "text02")
        buttonImageView.isUserInteractionEnabled = false
        buttonView.addSubview(chevronImageView)

        underline.backgroundColor = UIColor(named: "divider02")
        buttonView.addSubview(underline)

        buttonView.translatesAutoresizingMaskIntoConstraints = false
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        buttonImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        underline.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonView.widthAnchor.constraint(equalToConstant: 325),
            buttonView.heightAnchor.constraint(equalToConstant: 56),

            imageBackground.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            imageBackground.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            imageBackground.heightAnchor.constraint(equalToConstant: 48),
            imageBackground.widthAnchor.constraint(equalToConstant: 48),

            buttonImageView.centerXAnchor.constraint(equalTo: imageBackground.centerXAnchor),
            buttonImageView.centerYAnchor.constraint(equalTo: imageBackground.centerYAnchor),
            buttonImageView.heightAnchor.constraint(equalToConstant: 23),
            buttonImageView.widthAnchor.constraint(equalToConstant: 23),

            label.leadingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: imageBackground.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 225),
            label.heightAnchor.constraint(equalToConstant: 24),

            chevronImageView.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            chevronImageView.centerYAnchor.constraint(equalTo: imageBackground.centerYAnchor),
            chevronImageView.heightAnchor.constraint(equalToConstant: 24),
            chevronImageView.widthAnchor.constraint(equalToConstant: 24),

            underline.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -11),
            underline.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
            underline.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
