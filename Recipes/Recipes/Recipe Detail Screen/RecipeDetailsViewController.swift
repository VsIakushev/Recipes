// RecipeDetailsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран детального описания рецепта
final class RecipeDetailsViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let imageCellIdentifier = "ImageCell"
        static let caloriesCellIdentifier = "CaloriesCell"
        static let recipeCellIdentifier = "RecipeCell"
        static let numberOfSections = 3
    }
    
    // MARK: - Public Properties
    var presenter: RecipeDetailsPresenterProtocol?
    
    // MARK: - Private Properties
    private lazy var tableView = UITableView()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupNavigation()
    }
    
    // MARK: - Public Methods
    func setupUI() {
        view.backgroundColor = .cyan
    }
    
    // MARK: - Private Methods
    private func setupNavigation() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backButton
        
        let shareButton = UIBarButtonItem(
            image: UIImage(named: "telegram"),
            style: .plain,
            target: self,
            action: #selector(shareViaTelegramButtonTapped)
        )
        shareButton.tintColor = .black
        
        let addToFavoritesButton = UIBarButtonItem(
            image: UIImage(named: "addfavorites"),
            style: .plain,
            target: self,
            action: #selector(addToFavoritesTaped)
        )
        addToFavoritesButton.tintColor = .black
        
        navigationItem.rightBarButtonItems = [addToFavoritesButton, shareButton]
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: Constants.imageCellIdentifier)
        tableView.register(CaloriesTableViewCell.self, forCellReuseIdentifier: Constants.caloriesCellIdentifier)
        tableView.register(RecipeDescriptionTableViewCell.self, forCellReuseIdentifier: Constants.recipeCellIdentifier)
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
}

extension RecipeDetailsViewController: RecipeDetailsViewControllerProtocol {
    
    func showAlert() {
        let alertController = UIAlertController(title: "Предупреждение!", message: "Функционал в разработке", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
        
    }
    
    
    @objc func backButtonTapped() {
        print("go back")
        presenter?.closeDetailsScreen()
    }
    
    @objc func shareViaTelegramButtonTapped() {
        /// для реализации в дальнейшем
    }
    
    @objc func addToFavoritesTaped() {
        presenter?.addToFavorites()
    }
    
}

extension RecipeDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: Constants.imageCellIdentifier, for: indexPath ) as? ImageTableViewCell,
                  let presenter = presenter
            else { return UITableViewCell() }
            cell.configureCell(
                title: presenter.recipe.title,
                image: presenter.recipe.image,
                weight: presenter.recipe.weight,
                cookingTime: presenter.recipe.cookintTime
            )
            
            return cell
            
        } else if indexPath.row == 1 {
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: Constants.caloriesCellIdentifier,
                    for: indexPath
                ) as? CaloriesTableViewCell,
                  let presenter = presenter
            else { return UITableViewCell() }
            cell.configureCell(kcal: presenter.recipe.energicKcal,
                               carbohydrates: presenter.recipe.carbohydrates,
                               fats: presenter.recipe.fats,
                               proteins: presenter.recipe.proteins
            )
            return cell
            
        } else {
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: Constants.recipeCellIdentifier,
                    for: indexPath
                ) as? RecipeDescriptionTableViewCell,
                  let presenter = presenter
            else { return UITableViewCell() }
            cell.configureCell(text: presenter.recipe.recipeDescription)
            
            return cell
        }
    }
}
