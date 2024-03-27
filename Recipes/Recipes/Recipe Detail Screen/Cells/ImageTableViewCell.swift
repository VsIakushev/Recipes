// ImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка отображения фотографи Рецепта
class ImageTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let cookingTime = "Cooking time "
        static let min = " min"
        static let potIcon = "pot"
        static let timerIcon = "timer1"
    }

    // MARK: - Private Properties

    private let imageCacheService = ImageCacheProxy()

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

    func configureCell(recipe: Recipe) {
        backgroundColor = .white
        title = recipe.name
        image = recipe.image
        weight = Int(recipe.weight)
        cookingTime = recipe.cookingTime
        addViews()
        setupUI()
        setConstraints()
    }

    // MARK: - Private Methods

    private func addViews() {
        contentView.addSubview(recipeTitleLabel)
        contentView.addSubview(recipeImageView)

        if let imageURL = URL(string: image) {
            imageCacheService.loadImage(from: imageURL) { [weak self] image in
                DispatchQueue.main.async {
                    self?.recipeImageView.image = image
                    self?.recipeImageView.layer.cornerRadius = 24
                    self?.recipeImageView.clipsToBounds = true
                }
            }
        }

//        NetworkService.loadImage(from: image) { image in
//            DispatchQueue.main.async {
//                self.recipeImageView.image = image
//                self.recipeImageView.layer.cornerRadius = 24
//                self.recipeImageView.clipsToBounds = true
//            }
//        }
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
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        recipeImageView.image = UIImage(named: image)
        recipeImageView.layer.cornerRadius = 24
        recipeImageView.contentMode = .scaleAspectFit
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false

        roundView.backgroundColor = UIColor.background01().withAlphaComponent(0.6)
        roundView.layer.cornerRadius = 24
        roundView.translatesAutoresizingMaskIntoConstraints = false

        potImageView.image = UIImage(named: Constants.potIcon)
        potImageView.tintColor = .white
        potImageView.translatesAutoresizingMaskIntoConstraints = false

        weightLabel.text = "\(weight) g"
        weightLabel.textColor = .white
        weightLabel.font = UIFont.verdana10()
        weightLabel.textAlignment = .center
        weightLabel.translatesAutoresizingMaskIntoConstraints = false

        timerBackgroundView.backgroundColor = UIColor.background01().withAlphaComponent(0.6)
        timerBackgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        timerBackgroundView.layer.cornerRadius = 24
        timerBackgroundView.translatesAutoresizingMaskIntoConstraints = false

        timerImageView.image = UIImage(named: Constants.timerIcon)
        timerImageView.tintColor = .white
        timerImageView.translatesAutoresizingMaskIntoConstraints = false

        timerLabel.numberOfLines = 2
        timerLabel.text = Constants.cookingTime + String(cookingTime) + Constants.min
        timerLabel.textColor = .white
        timerLabel.font = UIFont.verdana10()
        timerLabel.textAlignment = .center
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setConstraints() {
        setRecipeTitleLabelConstraints()
        setRecipeImageViewConstraints()
        setRoundViewConstraints()
        setPotImageViewConstraints()
        setWeightLabelConstraints()
        setTimerBackgroundViewConstraints()
        setTimerImageViewConstraints()
        setTimerLabelConstraints()
    }

    private func setRecipeTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            recipeTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            recipeTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeTitleLabel.widthAnchor.constraint(equalToConstant: 350),
            recipeTitleLabel.heightAnchor.constraint(equalToConstant: 23)
        ])
    }

    private func setRecipeImageViewConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 20),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            recipeImageView.heightAnchor.constraint(equalTo: recipeImageView.widthAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    private func setRoundViewConstraints() {
        NSLayoutConstraint.activate([
            roundView.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 8),
            roundView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -6),
            roundView.heightAnchor.constraint(equalToConstant: 50),
            roundView.widthAnchor.constraint(equalTo: roundView.heightAnchor)
        ])
    }

    private func setPotImageViewConstraints() {
        NSLayoutConstraint.activate([
            potImageView.heightAnchor.constraint(equalToConstant: 19),
            potImageView.widthAnchor.constraint(equalToConstant: 22),
            potImageView.centerXAnchor.constraint(equalTo: roundView.centerXAnchor),
            potImageView.topAnchor.constraint(equalTo: roundView.topAnchor, constant: 7)
        ])
    }

    private func setWeightLabelConstraints() {
        NSLayoutConstraint.activate([
            weightLabel.widthAnchor.constraint(equalToConstant: 40),
            weightLabel.heightAnchor.constraint(equalToConstant: 16),
            weightLabel.centerXAnchor.constraint(equalTo: roundView.centerXAnchor),
            weightLabel.topAnchor.constraint(equalTo: potImageView.bottomAnchor, constant: 4)
        ])
    }

    private func setTimerBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            timerBackgroundView.widthAnchor.constraint(equalToConstant: 124),
            timerBackgroundView.heightAnchor.constraint(equalToConstant: 48),
            timerBackgroundView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor),
            timerBackgroundView.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor)
        ])
    }

    private func setTimerImageViewConstraints() {
        NSLayoutConstraint.activate([
            timerImageView.widthAnchor.constraint(equalToConstant: 25),
            timerImageView.heightAnchor.constraint(equalToConstant: 25),
            timerImageView.centerYAnchor.constraint(equalTo: timerBackgroundView.centerYAnchor),
            timerImageView.leadingAnchor.constraint(equalTo: timerBackgroundView.leadingAnchor, constant: 8)
        ])
    }

    private func setTimerLabelConstraints() {
        NSLayoutConstraint.activate([
            timerLabel.widthAnchor.constraint(equalToConstant: 83),
            timerLabel.heightAnchor.constraint(equalToConstant: 33),
            timerLabel.centerYAnchor.constraint(equalTo: timerBackgroundView.centerYAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: timerBackgroundView.trailingAnchor, constant: -8)
        ])
    }
}
