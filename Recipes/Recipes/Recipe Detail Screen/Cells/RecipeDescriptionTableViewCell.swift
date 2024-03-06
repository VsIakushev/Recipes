// RecipeDescriptionTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с подробным текстом рецепта
final class RecipeDescriptionTableViewCell: UITableViewCell {
    // MARK: - Constants
    
    // MARK: - Visual Components
    private let background = UIView()
    private let recipeLabel = UILabel()
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Public Methods
    
    func configureCell(text: String) {
        recipeLabel.text = text
        setupUI()
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            gradientLayer.frame = background.bounds
        }

    // MARK: - Private Methods
    private func setupUI() {
        contentView.addSubview(background)
        background.addSubview(recipeLabel)
        
        gradientLayer.colors = [UIColor.background04().cgColor , UIColor.white.cgColor]
        gradientLayer.frame = contentView.bounds
        background.layer.insertSublayer(gradientLayer, at: 0)

        background.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        background.layer.cornerRadius = 24
        background.clipsToBounds = true

        recipeLabel.numberOfLines = 0
        recipeLabel.font = UIFont.verdana14()
        
        background.translatesAutoresizingMaskIntoConstraints = false
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: contentView.topAnchor),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        
            recipeLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 27),
            recipeLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -40),
            recipeLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 27),
            recipeLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -27),
            
        ])
    }
    
}
