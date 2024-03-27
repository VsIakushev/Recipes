// ErrorDetailsCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

class ErrorDetailsCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let failedText = "Failed to load data"
        static let lightningImageName = "lightning"
        static let reloadText = " Reload"
    }

    // MARK: - Visual Components

    private let lightningImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.lightningImageName)
        return imageView
    }()

    private let lightningBackgroundView = {
        let view = UIView()
        view.backgroundColor = UIColor.background06()
        view.layer.cornerRadius = 12
        return view
    }()

    private let failedLabel = {
        var label = UILabel()
        label.font = UIFont.verdana14()
        label.textColor = UIColor.text03()
        label.text = Constants.failedText
        label.textAlignment = .center
        return label
    }()

    private let reloadButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "reload"), for: .normal)
        button.setTitle(Constants.reloadText, for: .normal)
        button.setTitleColor(.text03(), for: .normal)
        button.setTitleColor(.background08(), for: .focused)
        button.backgroundColor = .background06()
        button.layer.cornerRadius = 12
        return button
    }()

    var reloadButtonAction: VoidHandler?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setConstraints()
    }

    // MARK: - Private Methods

    private func setup() {
        contentView.frame = bounds
        addSubview(lightningBackgroundView)
        addSubview(failedLabel)
        lightningBackgroundView.addSubview(lightningImageView)
        addSubview(reloadButton)

        reloadButton.addTarget(self, action: #selector(reloadButtonPressed), for: .touchUpInside)
    }

    private func setConstraints() {
        lightningBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        failedLabel.translatesAutoresizingMaskIntoConstraints = false
        lightningImageView.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 600),

            lightningBackgroundView.widthAnchor.constraint(equalToConstant: 50),
            lightningBackgroundView.heightAnchor.constraint(equalToConstant: 50),
            lightningBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            lightningBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),

            lightningImageView.widthAnchor.constraint(equalToConstant: 10),
            lightningImageView.heightAnchor.constraint(equalToConstant: 18),
            lightningImageView.centerXAnchor.constraint(equalTo: lightningBackgroundView.centerXAnchor),
            lightningImageView.centerYAnchor.constraint(equalTo: lightningBackgroundView.centerYAnchor),

            failedLabel.widthAnchor.constraint(equalToConstant: 350),
            failedLabel.heightAnchor.constraint(equalToConstant: 16),
            failedLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            failedLabel.topAnchor.constraint(equalTo: lightningBackgroundView.bottomAnchor, constant: 17),

            reloadButton.widthAnchor.constraint(equalToConstant: 150),
            reloadButton.heightAnchor.constraint(equalToConstant: 32),
            reloadButton.topAnchor.constraint(equalTo: failedLabel.bottomAnchor, constant: 25),
            reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor)

        ])
    }

    @objc private func reloadButtonPressed() {
        reloadButtonAction?()
    }
}
