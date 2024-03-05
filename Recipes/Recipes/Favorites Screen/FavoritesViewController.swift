// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран избранных рецептов
final class FavoritesViewController: UIViewController {
    
    private enum Constants {
        static let cellIdendefire = "CellRecipes"
        static let titleText = "Favorites"
        static let titleFont = UIFont(name: "Verdana-Bold", size: 28)

    }
    
    // MARK: - Public Properties
    
    var recipes: [Recipes] = Recipes.exampleRecipe()
    var presenter: FavoritesPresenterProtocol?
    
    // MARK: - Public Methods
    
    func setupUI() {
        tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(named: "favorites"),
            selectedImage: UIImage(named: "favorites.fill")
        )
    }
    
    private lazy var recipesTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(RecipesCell.self, forCellReuseIdentifier: Constants.cellIdendefire)
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    func configureUI() {
        //        presenter?.getReceipts()
        view.backgroundColor = .white
        view.addSubview(recipesTableView)
        setupTitleLabel()
        makeAnchor()
    }
        
    private func setupTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.font = Constants.titleFont
        titleLabel.text = Constants.titleText
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    private func makeAnchor() {
        makeTableViewAnchor()
    }
}
    extension FavoritesViewController {
        private func makeTableViewAnchor() {
            recipesTableView.translatesAutoresizingMaskIntoConstraints = false
            recipesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            recipesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            recipesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            recipesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
// MARK: - UITableViewDelegate

    extension FavoritesViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            //presenter?.goToRecipeDetails()
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                recipes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    extension FavoritesViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            recipes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.cellIdendefire,
                for: indexPath
            ) as? RecipesCell
            else { return UITableViewCell() }
            cell.configure(with: recipes[indexPath.row])
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            125
        }
    }


// MARK: - FavoritesViewController + FavoritesViewControllerProtocol

extension FavoritesViewController: FavoritesViewControllerProtocol {}

extension FavoritesViewController: RecipesViewProtocol {
    func setScreenTitle(_ title: String) {
        
    }
    
    func getRecipes(recipes: [Recipes]) {
        self.recipes = recipes
        recipesTableView.reloadData()
    }
}
