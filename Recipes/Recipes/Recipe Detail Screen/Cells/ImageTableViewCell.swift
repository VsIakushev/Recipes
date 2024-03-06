// ImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

class ImageTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
       
        static let cookingTime = "Cooking time "
        static let min = " min"
        static let potIcon = "pot"
        static let timerIcon = "timer1"
    }

    // MARK: - Public Properties

    private var title = ""
    private var image = ""
    private var weight = 0
    private var cookingTime = 0

    // MARK: - Visual Components

    private let recipeTitleLabel = UILabel()
    private let recipeImageView = UIImageView()
    private let roundView = UIView()
    private let potImageView = UIImageView()
    private let weightLabel = UILabel()
    private let timerBackgroundView = UIView()
    private let timerImageView = UIImageView()
    private let timerLabel = UILabel()

    // MARK: - Public Methods

    func configureCell(title: String, image: String, weight: Int, cookingTime: Int) {
        backgroundColor = .white
        self.title = title
        self.image = image
        self.weight = weight
        self.cookingTime = cookingTime
        addViews()
        setupUI()
        setConstraints()
    }

    // MARK: - Private Methods

    private func addViews() {
        contentView.addSubview(recipeTitleLabel)
        contentView.addSubview(recipeImageView)
        
        recipeImageView.addSubview(roundView)
        roundView.addSubview(potImageView)
        roundView.addSubview(weightLabel)
        recipeImageView.addSubview(timerBackgroundView)
        timerBackgroundView.addSubview(timerImageView)
        timerBackgroundView.addSubview(timerLabel)
    }

    private func setupUI() {
        recipeTitleLabel.text = title
        recipeTitleLabel.font = UIFont.verdanaBold20()
        recipeTitleLabel.textAlignment = .center

        recipeImageView.image = UIImage(named: image)
        recipeImageView.layer.cornerRadius = 24
        recipeImageView.contentMode = .scaleAspectFit

        roundView.backgroundColor = UIColor.background01().withAlphaComponent(0.6)
        roundView.layer.cornerRadius = 24
        
        potImageView.image = UIImage(named: Constants.potIcon)
        potImageView.tintColor = .white
        
        weightLabel.text = "\(weight) g"
        weightLabel.textColor = .white
        weightLabel.font = UIFont.verdana10()
        weightLabel.textAlignment = .center
        
        timerBackgroundView.backgroundColor = UIColor.background01().withAlphaComponent(0.6)
        timerBackgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        timerBackgroundView.layer.cornerRadius = 24
        
        timerImageView.image = UIImage(named: Constants.timerIcon)
        timerImageView.tintColor = .white
        
        timerLabel.numberOfLines = 2
        timerLabel.text = Constants.cookingTime + String(cookingTime) + Constants.min
        timerLabel.textColor = .white
        timerLabel.font = UIFont.verdana10()
        timerLabel.textAlignment = .center
    }

    private func setConstraints() {
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        roundView.translatesAutoresizingMaskIntoConstraints = false
        potImageView.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        timerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        timerImageView.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            recipeTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            recipeTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeTitleLabel.widthAnchor.constraint(equalToConstant: 350),
            recipeTitleLabel.heightAnchor.constraint(equalToConstant: 23),

            recipeImageView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 20),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            recipeImageView.heightAnchor.constraint(equalTo: recipeImageView.widthAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            roundView.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 8),
            roundView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -6),
            roundView.heightAnchor.constraint(equalToConstant: 50),
            roundView.widthAnchor.constraint(equalTo: roundView.heightAnchor),
            
            potImageView.heightAnchor.constraint(equalToConstant: 19),
            potImageView.widthAnchor.constraint(equalToConstant: 22),
            potImageView.centerXAnchor.constraint(equalTo: roundView.centerXAnchor),
            potImageView.topAnchor.constraint(equalTo: roundView.topAnchor, constant: 7),
            
            weightLabel.widthAnchor.constraint(equalToConstant: 40),
            weightLabel.heightAnchor.constraint(equalToConstant: 16),
            weightLabel.centerXAnchor.constraint(equalTo: roundView.centerXAnchor),
            weightLabel.topAnchor.constraint(equalTo: potImageView.bottomAnchor, constant: 4),
            
            timerBackgroundView.widthAnchor.constraint(equalToConstant: 124),
            timerBackgroundView.heightAnchor.constraint(equalToConstant: 48),
            timerBackgroundView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor),
            timerBackgroundView.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
            
            timerImageView.widthAnchor.constraint(equalToConstant: 25),
            timerImageView.heightAnchor.constraint(equalToConstant: 25),
            timerImageView.centerYAnchor.constraint(equalTo: timerBackgroundView.centerYAnchor),
            timerImageView.leadingAnchor.constraint(equalTo: timerBackgroundView.leadingAnchor, constant: 8),
            
            timerLabel.widthAnchor.constraint(equalToConstant: 83),
            timerLabel.heightAnchor.constraint(equalToConstant: 33),
            timerLabel.centerYAnchor.constraint(equalTo: timerBackgroundView.centerYAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: timerBackgroundView.trailingAnchor, constant: -8)
        ])
    }
}
