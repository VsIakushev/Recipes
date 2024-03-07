// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран избранных рецептов
final class FavoritesViewController: UIViewController {
    private enum Constants {
        static let cellIdendefire = "CellRecipes"
        static let titleText = "Favorites"
        static let titleFont = UIFont(name: "Verdana-Bold", size: 28)
        static let emptyLabelText = "There's nothing here yet"
        static let additionalEmptyLabelText = "Add interesting recipes to make ordering products convenient"
        static let tabBarImageName = "favorites"
        static let tabBarFillImageName = "favorites.fill"
        static let addFavImageName = "addfavorites 1"
        static let verdanaBold = "Verdana-Bold"
        static let verdana = "Verdana"
    }

    // MARK: - Public Properties

    var recipes: [Recipes] = []
    var presenter: FavoritesPresenterProtocol?

    // MARK: - Public Methods

    func setupUI() {
        tabBarItem = UITabBarItem(
            title: Constants.titleText,
            image: UIImage(named: Constants.tabBarImageName),
            selectedImage: UIImage(named: Constants.tabBarFillImageName)
        )
    }

    // MARK: - Visual Components

    private lazy var recipesTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(RecipesCell.self, forCellReuseIdentifier: Constants.cellIdendefire)
        table.showsVerticalScrollIndicator = false
        return table
    }()

    private let emptyMessageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let iconView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = UIColor.background08()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.addFavImageName)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.emptyLabelText
        label.font = UIFont.verdanaBold20()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let additionalEmptyLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.additionalEmptyLabelText
        label.font = UIFont.verdana14()
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        getFavRecipes()
        view.backgroundColor = .white
        view.addSubview(emptyMessageView)
        emptyMessageView.addSubview(iconView)
        emptyMessageView.addSubview(iconImageView)
        emptyMessageView.addSubview(emptyLabel)
        emptyMessageView.addSubview(additionalEmptyLabel)
        setupTitleLabel()
        view.addSubview(recipesTableView)
        makeAnchor()
    }

    private func setupTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.verdanaBold28()
        titleLabel.text = Constants.titleText
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    private func makeAnchor() {
        makeTableViewAnchor()
        setEmptyMessageViewConstraints()
        setIconViewConstraints()
        setIconImageViewConstraints()
        setEmptyLabelConstraints()
        setAdditionalEmptyLabelConstraints()
    }
}

// MARK: - Extension

extension FavoritesViewController {
    private func makeTableViewAnchor() {
        recipesTableView.translatesAutoresizingMaskIntoConstraints = false
        recipesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
            .isActive = true
        recipesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recipesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recipesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func setEmptyMessageViewConstraints() {
        emptyMessageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
            .isActive = true
        emptyMessageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            .isActive = true
        emptyMessageView.heightAnchor.constraint(equalToConstant: 132).isActive = true
        emptyMessageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }

    private func setIconViewConstraints() {
        iconView.centerXAnchor.constraint(equalTo: emptyMessageView.centerXAnchor).isActive = true
        iconView.topAnchor.constraint(equalTo: emptyMessageView.topAnchor).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor).isActive = true
    }

    private func setIconImageViewConstraints() {
        iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private func setEmptyLabelConstraints() {
        emptyLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 16).isActive = true
        emptyLabel.centerXAnchor.constraint(equalTo: emptyMessageView.centerXAnchor).isActive = true
    }

    private func setAdditionalEmptyLabelConstraints() {
        additionalEmptyLabel.topAnchor.constraint(equalTo: emptyLabel.bottomAnchor, constant: 8).isActive = true
        additionalEmptyLabel.leadingAnchor.constraint(equalTo: emptyMessageView.leadingAnchor, constant: 16)
            .isActive = true
        additionalEmptyLabel.trailingAnchor.constraint(equalTo: emptyMessageView.trailingAnchor, constant: -16)
            .isActive = true
    }
}

// MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            presenter?.removeFromFavourites(recipeIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            presenter?.checkIfFavouritesEmpty()
        }
    }
}

// MARK: - UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getFavouritesCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdendefire,
            for: indexPath
        ) as? RecipesCell,
            let favorites = presenter?.getFavourites()
        else { return UITableViewCell() }
        cell.configure(with: favorites[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }
}

// MARK: - FavoritesViewController + FavoritesViewControllerProtocol

extension FavoritesViewController: FavoritesViewControllerProtocol {
    func setEmptyState() {
        recipesTableView.isHidden = true
    }

    func setNonEmptyState() {
        recipesTableView.isHidden = false
    }

    func getFavRecipes() {
        recipes = presenter?.getFavourites() ?? []
        recipesTableView.reloadData()
    }
}

extension FavoritesViewController: RecipesViewProtocol {
    func buttonTimeState(color: String, image: String) {}

    func buttonCaloriesState(color: String, image: String) {}

    func sortViewRecipes(recipes: [Recipes]) {}

    func reloadTableView() {
        recipesTableView.reloadData()
    }

    func getRecipes(recipes: [Recipes]) {}

    func goToTheCategory() {}

    func setTitle(_ title: String) {}

    func getRecipes() {
        // recipes = presenter?.getFavourites() ?? []
//        recipesTableView.reloadData()
    }
}
