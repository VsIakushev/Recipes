// Button.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кнопка перезагрузки данных
final class Button: UIButton {
    // MARK: - Constants

    private enum Constants {
        static let reloadText = "Reload"
    }

    // MARK: - Visual Components

    private let mainImage = {
        let image = UIImageView()
        image.contentMode = .center
        image.image = UIImage(named: "bolt")?.withTintColor(.text03(), renderingMode: .alwaysOriginal)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let textLabel = {
        let label = UILabel()
        label.font = .verdana14()
        label.textColor = .placeholderText
        label.text = Constants.reloadText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [mainImage, textLabel])
        stack.spacing = 9
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        CGSize(width: 150, height: 32)
    }

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        self
    }

    // MARK: - Private Methods

    private func configureUI() {
        layer.cornerRadius = 12
        backgroundColor = .background08()
        addSubview(stackView)
    }

    private func configureLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]

        constraints.forEach { $0.isActive = true }
    }
}
