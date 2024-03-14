// RecipesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с рецептами
final class RecipesCell: UITableViewCell {
    private enum Constants {
        static let timerImageViewName = "timer"
        static let pizzaImageViewName = "pizza"
        static let nextButtonImageName = "chevron.right"
        static let timeLabelText = " min"
        static let pizzaLabelText = " kkal"
    }

    // MARK: - VIsual Components

    private let backgroundCellView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.background06()
        uiView.layer.cornerRadius = 12
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()

    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleRecipeLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.verdana14()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.verdana12()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.timerImageViewName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let pizzaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.pizzaImageViewName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let pizzaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.verdana12()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: Constants.nextButtonImageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupViews()
        setupAnchors()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupAnchors()
    }

    // MARK: - Public Methods
    func configure(with items: Recipe) {
//    func configure(with items: RecipeNetwork) {
        recipeImageView.image = UIImage(named: items.image)
//        print(items.image)
//        loadImage(from: items.image) { image in
//            if let image = image {
//                   // Используем загруженное изображение
//                   DispatchQueue.main.async {
//                       // Например, установим его в imageView
//                       self.imageView?.image = image
//                       self.setupViews()
//                   }
//               } else {
//                  print("ошибка при загрузке изображения")
//               }
//        }
        titleRecipeLabel.text = items.title
        timeLabel.text = String(items.cookingTime) + Constants.timeLabelText
        pizzaLabel.text = String(describing: items.energicKcal) + Constants.pizzaLabelText
    }

    // MARK: - Private Methods
    
    private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: imageUrl) { (data, response, error) in
            guard error == nil, let data = data else {
                print("Failed to load image:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Failed to create image from data")
                completion(nil)
            }
        }
        task.resume()
    }

    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(backgroundCellView)
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleRecipeLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(timerImageView)
        contentView.addSubview(pizzaImageView)
        contentView.addSubview(pizzaLabel)
        contentView.addSubview(nextButton)
    }

    private func setupAnchors() {
        setupAnchorsUiViewBackground()
        setupAnchorsRecipeImageView()
        setupAnchorsTitleRecipe()
        setupAnchorsTimeLabel()
        setupAnchorsTimerImageView()
        setupAnchorsPizzaImageView()
        setupAnchorsPizzaLabel()
        setupAnchorsNextButton()
    }

    private func setupAnchorsUiViewBackground() {
        backgroundCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        backgroundCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        backgroundCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        backgroundCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        backgroundCellView.heightAnchor.constraint(equalToConstant: 153).isActive = true
    }

    private func setupAnchorsRecipeImageView() {
        recipeImageView.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: 10)
            .isActive = true
        recipeImageView.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: 10).isActive = true
        recipeImageView.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: -10).isActive = true
    }

    private func setupAnchorsTitleRecipe() {
        titleRecipeLabel.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: 22).isActive = true
        titleRecipeLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        titleRecipeLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    private func setupAnchorsTimeLabel() {
        timeLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 40).isActive = true
        timeLabel.topAnchor.constraint(equalTo: titleRecipeLabel.bottomAnchor, constant: 20).isActive = true
    }

    private func setupAnchorsTimerImageView() {
        timerImageView.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 22)
            .isActive = true
        timerImageView.topAnchor.constraint(equalTo: titleRecipeLabel.bottomAnchor, constant: 19).isActive = true
    }

    private func setupAnchorsPizzaImageView() {
        pizzaImageView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 37).isActive = true
        pizzaImageView.topAnchor.constraint(equalTo: titleRecipeLabel.bottomAnchor, constant: 19).isActive = true
    }

    private func setupAnchorsPizzaLabel() {
        pizzaLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 55).isActive = true
        pizzaLabel.topAnchor.constraint(equalTo: titleRecipeLabel.bottomAnchor, constant: 20).isActive = true
    }

    private func setupAnchorsNextButton() {
        nextButton.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -16)
            .isActive = true
        nextButton.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: 40).isActive = true
    }
}
