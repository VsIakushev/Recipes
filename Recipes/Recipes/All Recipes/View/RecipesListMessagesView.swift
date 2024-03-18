// RecipesListMessagesView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

class RecipesListMessagesView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let nothingFoundText = "Nothing found"
        static let failedToLoadText = "Failed to load data"
        static let tryEnteringQueryText = "Try entering your query differently"
        static let startTypingText = "Start typing text"
    }

    ///  Перечисление стейтов
    enum State {
        /// Данных нет
        case nothingFound
        /// Ошибка
        case error
        /// Скрыт
        case hidden
        /// Начните поиск
        case startTyping
    }

    // MARK: - Visual Components

    private let mainImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.layer.cornerRadius = 12
        view.backgroundColor = .background08()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel = {
        let label = UILabel()
        label.font = .verdanaBold18()
        label.textAlignment = .center
        label.textColor = .label
        label.text = Constants.nothingFoundText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let captionLabel = {
        let label = UILabel()
        label.font = .verdana14()
        label.textAlignment = .center
        label.textColor = .placeholderText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let reloadButton = Button()

    private lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, captionLabel, reloadButton])
        stack.axis = .vertical
        stack.spacing = 17
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

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

    func switchState(_ state: State) {
        switch state {
        case .nothingFound:
            isHidden = false
            mainImageView.image = UIImage(named: "search")
            captionLabel.text = Constants.tryEnteringQueryText
            titleLabel.isHidden = false
            reloadButton.isHidden = true
        case .error:
            isHidden = false
            mainImageView.image = UIImage(named: "bolt")
            captionLabel.text = Constants.failedToLoadText
            titleLabel.isHidden = true
            reloadButton.isHidden = false
        case .hidden:
            isHidden = true
        case .startTyping:
            mainImageView.image = UIImage(named: "search")
            captionLabel.text = Constants.startTypingText
            titleLabel.isHidden = true
            reloadButton.isHidden = true
        }
    }

    func addTarget(_ target: Any?, action: Selector) {
        reloadButton.addTarget(target, action: action, for: .touchUpInside)
    }

    // MARK: - Private Methods

    private func configureUI() {
        addSubview(mainImageView)
        addSubview(stackView)
    }

    private func configureLayout() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 50),
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor),

            stackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 17),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        constraints.forEach { $0.isActive = true }
    }
}
