// CaloriesTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка отображения калорий и БЖУ
final class CaloriesTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let calories = "Enerc kcal"
        static let carbohydrates = "Carbohydrates"
        static let fats = "Fats"
        static let proteins = "Proteins"
    }

    // MARK: - Visual Components

    private var kcalView = UIView()
    private var carbonhedratesView = UIView()
    private var fatsView = UIView()
    private var proteinsView = UIView()
    private var stackView = UIStackView()

    // MARK: - Public Methods

    func configureCell(kcal: Int, carbohydrates: Double, fats: Double, proteins: Double) {
        kcalView = createCellElement(
            title: Constants.calories,
            parameter: "\(kcal) kcal"
        )
        carbonhedratesView = createCellElement(
            title: Constants.carbohydrates,
            parameter: "\(String(format: "%.2f", carbohydrates)) g"
        )
        fatsView = createCellElement(
            title: Constants.fats,
            parameter: "\(String(format: "%.2f", fats)) g"
        )
        proteinsView = createCellElement(
            title: Constants.proteins,
            parameter: "\(String(format: "%.2f", proteins)) g"
        )

        stackView = UIStackView(arrangedSubviews: [kcalView, carbonhedratesView, fatsView, proteinsView])

        setupUI()
        setConstraints()
    }

    private func setupUI() {
        backgroundColor = .white
        
        contentView.removeAllSubviews()
        contentView.addSubview(stackView)
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
    }

    private func createCellElement(title: String, parameter: String) -> UIView {
        let cellElementView = UIView()
        let blueTopView = UIView()
        let titleLabel = UILabel()
        let parameterLabel = UILabel()

        contentView.addSubview(cellElementView)
        cellElementView.addSubview(blueTopView)
        cellElementView.addSubview(titleLabel)
        blueTopView.addSubview(parameterLabel)

        cellElementView.layer.cornerRadius = 16
        cellElementView.layer.borderWidth = 2
        cellElementView.layer.borderColor = UIColor.background01().cgColor

        blueTopView.backgroundColor = UIColor.background01()
        blueTopView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        blueTopView.layer.cornerRadius = 16

        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.verdana10()
        titleLabel.adjustsFontSizeToFitWidth = true

        parameterLabel.text = parameter
        parameterLabel.textColor = UIColor.background01()
        parameterLabel.textAlignment = .center
        parameterLabel.font = UIFont.verdana10()
        parameterLabel.adjustsFontSizeToFitWidth = true

        cellElementView.translatesAutoresizingMaskIntoConstraints = false
        blueTopView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        parameterLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cellElementView.widthAnchor.constraint(equalToConstant: 75),
            cellElementView.heightAnchor.constraint(equalToConstant: 53),

            blueTopView.centerXAnchor.constraint(equalTo: cellElementView.centerXAnchor),
            blueTopView.topAnchor.constraint(equalTo: cellElementView.topAnchor),
            blueTopView.widthAnchor.constraint(equalTo: cellElementView.widthAnchor),
            blueTopView.heightAnchor.constraint(equalToConstant: 31),

            titleLabel.centerXAnchor.constraint(equalTo: blueTopView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: blueTopView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 14),
            titleLabel.widthAnchor.constraint(equalToConstant: 72),

            parameterLabel.centerXAnchor.constraint(equalTo: cellElementView.centerXAnchor),
            parameterLabel.bottomAnchor.constraint(equalTo: cellElementView.bottomAnchor, constant: -4),
            parameterLabel.heightAnchor.constraint(equalToConstant: 15),
            parameterLabel.widthAnchor.constraint(equalToConstant: 64)
        ])
        return cellElementView
    }

    private func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}

extension UIView {
    func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}
