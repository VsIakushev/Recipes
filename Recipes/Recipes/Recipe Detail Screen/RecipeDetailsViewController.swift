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
        static let imageShimmerCellIdentifier = "imageShimmer"
        static let errorDetailsCellIdentifier = "errorDetailsCellIdentifier"
        static let numberOfSections = 3
    }
    
    // MARK: - Public Properties
    
    var presenter: RecipeDetailsPresenterProtocol?
    var officiant: Invoker? = Invoker.shared
    let favoritesSingletone = FavoritesSingletone.shared
    var recipe: Recipe? {
        didSet {
            setupNavigation()
        }
    }
    
    // MARK: - Private Properties
    
    private lazy var tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipe()
        setupUI()
        setupTableView()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        order(command: OpenDetailedRecipeScreenCommand())
    }
    
    // MARK: - Public Methods
    
    func setupUI() {
        view.backgroundColor = .cyan
    }
    
    // MARK: - Private Methods
    
    private func getRecipe() {
        presenter?.getRecipe()
    }
    
    private func order(command: Command) {
        guard let officiant = officiant else {
            print("error")
            return
        }
        officiant.addCommand(OpenDetailedRecipeScreenCommand())
        officiant.executeCommands()
    }
    
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
            image: UIImage(named: recipe?.isFavorite ?? false ? "favoritesred" : "addfavorites"),
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
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: Constants.imageCellIdentifier)
        tableView.register(CaloriesTableViewCell.self, forCellReuseIdentifier: Constants.caloriesCellIdentifier)
        tableView.register(RecipeDescriptionTableViewCell.self, forCellReuseIdentifier: Constants.recipeCellIdentifier)
        tableView.register(ErrorDetailsCell.self, forCellReuseIdentifier: Constants.errorDetailsCellIdentifier)
        tableView.register(ShimmerCell.self, forCellReuseIdentifier: Constants.imageShimmerCellIdentifier)
        
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
        
    @objc private func refreshData() {
                self.getRecipe()
    }
}

extension RecipeDetailsViewController: RecipeDetailsViewControllerProtocol {
    
    func updateState() {
        switch presenter?.state {
        case .loading:
            break
        case .data:
            tableView.reloadData()
            tableView.refreshControl?.endRefreshing()
        case .noData:
            tableView.reloadData()
        case .error:
            tableView.reloadData()
        case .none:
            break
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(
            title: "Предупреждение!",
            message: "Функционал в разработке",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @objc func backButtonTapped() {
        presenter?.closeDetailsScreen()
    }
    
    @objc func shareViaTelegramButtonTapped() {
        presenter?.shareViaTelegram()
    }
    
    @objc func addToFavoritesTaped() {
        guard let recipe = favoritesSingletone.recipeFromList else {
            return
        }
        navigationItem.rightBarButtonItems?[0].image = UIImage(named: "favoritesred")
        navigationItem.rightBarButtonItems?[0].tintColor = .background03()
        presenter?.addToFavorites()
    }
}

extension RecipeDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch presenter?.state {
        case .data:
            Constants.numberOfSections
        case .loading, .noData, .error, .none:
            1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch presenter?.state {
        case .data(let recipe):
            if indexPath.row == 0 {
                guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: Constants.imageCellIdentifier, for: indexPath
                    ) as? ImageTableViewCell,
                      let presenter = presenter
                else { return UITableViewCell() }
                
                cell.configureCell(recipe: recipe)
             
                return cell
                
            } else if indexPath.row == 1 {
                guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: Constants.caloriesCellIdentifier,
                        for: indexPath
                    ) as? CaloriesTableViewCell,
                      let presenter = presenter
                else { return UITableViewCell() }
                cell.configureCell(recipe: recipe)
                return cell
                
            } else {
                guard let cell = tableView
                    .dequeueReusableCell(
                        withIdentifier: Constants.recipeCellIdentifier,
                        for: indexPath
                    ) as? RecipeDescriptionTableViewCell,
                      let presenter = presenter
                else { return UITableViewCell() }
                cell.configureCell(recipe: recipe)
                
                return cell
            }
        case .loading:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.imageShimmerCellIdentifier, for: indexPath) as? ShimmerCell else { return UITableViewCell() }
            
            return cell
        case .noData, .error, .none:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.errorDetailsCellIdentifier, for: indexPath) as? ErrorDetailsCell else { return UITableViewCell() }
            return cell
        }
    }
}
