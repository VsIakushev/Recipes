// RecipeDescriptionTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с подробным текстом рецепта
final class RecipeDescriptionTableViewCell: UITableViewCell {
    // MARK: - Constants

    // MARK: - Visual Components

    private let descriptionBackgroundView = UIView()
    private let recipeLabel = UILabel()
    private let gradientLayer = CAGradientLayer()

    // MARK: - Public Methods

    func configureCell(recipe: Recipe) {
        recipeLabel.text = recipe.ingredientLines.joined(separator: "\n")
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = descriptionBackgroundView.bounds
    }

    // MARK: - Private Methods

    private func setupUI() {
        contentView.addSubview(descriptionBackgroundView)
        descriptionBackgroundView.addSubview(recipeLabel)

        gradientLayer.colors = [UIColor.background04().cgColor, UIColor.white.cgColor]
        gradientLayer.frame = contentView.bounds
        descriptionBackgroundView.layer.insertSublayer(gradientLayer, at: 0)

        descriptionBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        descriptionBackgroundView.layer.cornerRadius = 24
        descriptionBackgroundView.clipsToBounds = true

        recipeLabel.numberOfLines = 0
        recipeLabel.font = UIFont.verdana14()

        descriptionBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            descriptionBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            descriptionBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            recipeLabel.topAnchor.constraint(equalTo: descriptionBackgroundView.topAnchor, constant: 27),
            recipeLabel.bottomAnchor.constraint(equalTo: descriptionBackgroundView.bottomAnchor, constant: -40),
            recipeLabel.leadingAnchor.constraint(equalTo: descriptionBackgroundView.leadingAnchor, constant: 27),
            recipeLabel.trailingAnchor.constraint(equalTo: descriptionBackgroundView.trailingAnchor, constant: -27),

        ])
    }
}
