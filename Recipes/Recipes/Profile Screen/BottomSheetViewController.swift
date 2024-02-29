// BottomSheetViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// "Шторка" для отображения бонусов пользователя
final class BottomSheetViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Your bonuses"
        static let titleFons = UIFont(name: "Verdana-Bold", size: 20)
        static let bonusesFont = UIFont(name: "Verdana-Bold", size: 30)
    }

    // MARK: - Visual Components

    let closeButton = UIButton()
    let bonusTitleLabel = UILabel()
    let bonusImageView = UIImageView()
    let starImageView = UIImageView()
    let bonusesLabel = UILabel()

    // MARK: - Public Properties

    var presenter: BottomSheetPresentorProtocol?
    private var bonuses = 0

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Public Methods

    func setBonuses(bonuses: Int) {
        self.bonuses = bonuses
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(bonusTitleLabel)
        view.addSubview(bonusImageView)
        view.addSubview(starImageView)
        view.addSubview(bonusesLabel)

        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = UIColor(named: "text02")
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        bonusTitleLabel.text = Constants.titleText
        bonusTitleLabel.font = Constants.titleFons
        bonusTitleLabel.textAlignment = .center
        bonusTitleLabel.textColor = UIColor(named: "text02")

        bonusImageView.image = UIImage(named: "bonus")

        starImageView.image = UIImage(named: "stargold")

        bonusesLabel.text = "\(bonuses)"
        bonusesLabel.textAlignment = .left
        bonusesLabel.font = Constants.bonusesFont
        bonusesLabel.textColor = UIColor(named: "text02")

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        bonusTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bonusImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        bonusesLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            closeButton.widthAnchor.constraint(equalToConstant: 13),
            closeButton.heightAnchor.constraint(equalToConstant: 13),

            bonusTitleLabel.widthAnchor.constraint(equalToConstant: 350),
            bonusTitleLabel.heightAnchor.constraint(equalToConstant: 24),
            bonusTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bonusTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),

            bonusImageView.widthAnchor.constraint(equalToConstant: 150),
            bonusImageView.heightAnchor.constraint(equalToConstant: 136),
            bonusImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bonusImageView.topAnchor.constraint(equalTo: bonusTitleLabel.bottomAnchor, constant: 13),

            starImageView.widthAnchor.constraint(equalToConstant: 29),
            starImageView.heightAnchor.constraint(equalToConstant: 28),
            starImageView.leadingAnchor.constraint(equalTo: bonusImageView.leadingAnchor, constant: 24),
            starImageView.topAnchor.constraint(equalTo: bonusImageView.bottomAnchor, constant: 31),

            bonusesLabel.widthAnchor.constraint(equalToConstant: 177),
            bonusesLabel.heightAnchor.constraint(equalToConstant: 35),
            bonusesLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 14),
            bonusesLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor)
        ])
    }

    @objc private func closeButtonTapped() {
        presenter?.closeButtonPressed()
    }
}

extension BottomSheetViewController: BottomSheetViewControllerProtocol {}
