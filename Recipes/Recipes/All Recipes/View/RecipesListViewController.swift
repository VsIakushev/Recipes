// RecipesListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таблица  с рецептами
final class RecipesListViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let cellIdendefire = "CellRecipes"
        static let skeletonCellIdIdentifier = "CellSkeleton"
        static let filterIconImage = UIImage(named: "filterIcon")
        static let titleNavigation = "Fish"
        static let serchPlaceholder = "Search recipes"
        static let caloriesButtonTitle = "Calories"
        static let timeButtonTitle = "Time"
        static let arrowBack = "arrowBack"
    }

    // MARK: - Visual Components

    let caloriesButton = UIButton()
    let timeButton = UIButton()
    private let refreshControl = UIRefreshControl()

    private lazy var recipesListMessagesView = {
            let view = RecipesListMessagesView()
            view.addTarget(self, action: #selector(reloadButtonTapped))
            return view
        }()
    
    private lazy var recipesTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        table.separatorStyle = .none
        table.register(RecipesCell.self, forCellReuseIdentifier: Constants.cellIdendefire)
        table.register(ShimmerRecipesCell.self, forCellReuseIdentifier: Constants.skeletonCellIdIdentifier)
        table.showsVerticalScrollIndicator = false
        return table
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.verdanaBold28()
        label.textColor = .black
        return label
    }()

    private lazy var backButton: UIButton = {
        let view = UIView()
        let button = UIButton()
        button.setImage(UIImage(named: Constants.arrowBack), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = Constants.serchPlaceholder
        search.backgroundImage = UIImage()
        search.delegate = self
        return search
    }()

    // MARK: - Public Properties

    var recipes: [Recipe] = []
    var categoryTitle: String = ""
    var presenter: AllRecipesPresenter?
    var officiant: Invoker? = Invoker.shared
    var favoritesSingletone = FavoritesSingletone.shared
    var recipesNetwork: [Recipe] = []
    var networkService = NetworkService()

    // MARK: - Private Properties


    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hidesBottomBarWhenPushed = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = categoryTitle
        order(command: OpenAllRecipesScreenCommand())
    }

    // MARK: - Private Methods

    func setupUI() {
        updateState()
        presenter?.getReceipts()
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(recipesTableView)
        view.addSubview(recipesListMessagesView)
        makeFilterButton(button: caloriesButton, title: Constants.caloriesButtonTitle)
        makeFilterButton(button: timeButton, title: Constants.timeButtonTitle)
        makeAnchor()

        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: backButton),
            UIBarButtonItem(customView: titleLabel)
        ]
    }

    private func order(command: Command) {
        guard let officiant = officiant else {
            print("error")
            return
        }
        officiant.addCommand(OpenAllRecipesScreenCommand())
        officiant.executeCommands()
    }

    private func makeFilterButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setImage(Constants.filterIconImage, for: .normal)
        button.backgroundColor = UIColor.background06()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 10)
        timeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 10)
        caloriesButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
        timeButton.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        caloriesButton.addTarget(self, action: #selector(caloriesButtonTapped), for: .touchUpInside)
        view.addSubview(button)
    }

    private func makeAnchor() {
        makeAnchorsSearchBar()
        setupAnchorsCaloriesButton()
        setupAnchorsTimeButton()
        makeTableViewAnchor()
        setupAnchorsRecipesListMessagesView()
    }

    @objc private func caloriesButtonTapped() {
        presenter?.buttonCaloriesChange()
    }

    @objc private func timeButtonTapped() {
        presenter?.buttonTimeChange()
    }

    @objc private func backButtonTapped() {
        presenter?.goToCategory()
    }
    
    @objc private func reloadButtonTapped() {
            presenter?.getReceipts()
        }
}

// MARK: - Extension

extension RecipesListViewController {
    private func makeAnchorsSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 96).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: 335).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func makeTableViewAnchor() {
        recipesTableView.translatesAutoresizingMaskIntoConstraints = false
        recipesTableView.topAnchor.constraint(equalTo: timeButton.bottomAnchor, constant: 10).isActive = true
        recipesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recipesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recipesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func setupAnchorsCaloriesButton() {
        caloriesButton.translatesAutoresizingMaskIntoConstraints = false
        caloriesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        caloriesButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
        caloriesButton.widthAnchor.constraint(equalToConstant: 112).isActive = true
        caloriesButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func setupAnchorsTimeButton() {
        timeButton.translatesAutoresizingMaskIntoConstraints = false
        timeButton.leadingAnchor.constraint(equalTo: caloriesButton.trailingAnchor, constant: 11).isActive = true
        timeButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
        timeButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        timeButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    private func setupAnchorsRecipesListMessagesView() {
        recipesListMessagesView.translatesAutoresizingMaskIntoConstraints = false
        recipesListMessagesView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        recipesListMessagesView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
}

// MARK: - UITableViewDelegate

extension RecipesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard case .data(let recipes) = presenter?.state else { return }
        guard indexPath.row < recipes.count else { return }
        let selectedRecipe = recipes[indexPath.row]
        favoritesSingletone.getRecipeFromList(selectedRecipe)
        presenter?.goToRecipeDetails(with: selectedRecipe)
    }
}

// MARK: - UITableViewDataSource

extension RecipesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch presenter?.state {
        case .loading:
            return 7
        case .data(let recipes):
            return recipes.count
        case .noData, .error, .none:
            return 0
        }
    }

    func updateState() {
        guard let presenter else { return }
        switch presenter.state {
        case .loading:
//            recipesTableView.reloadData()
            recipesListMessagesView.switchState(.hidden)
        case .data:
            recipesTableView.reloadData()
            recipesTableView.refreshControl?.endRefreshing()
            recipesListMessagesView.switchState(.hidden)
        case .noData:
            recipesListMessagesView.switchState(.nothingFound)
            recipesTableView.isHidden = true

//            recipesTableView.reloadData()

        case .error:
            recipesListMessagesView.switchState(.error)
//            recipesTableView.isHidden = true

//            recipesTableView.reloadData()

        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter?.state {
            
        case .loading:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.skeletonCellIdIdentifier,
                for: indexPath
            ) as? ShimmerRecipesCell else { return UITableViewCell() }
            return cell
            
        case .data(let recipes):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.cellIdendefire,
                for: indexPath
            ) as? RecipesCell else { return UITableViewCell() }
            cell.configure(with: recipes[indexPath.row])
            return cell
            
        case .noData, .error, .none:
            break
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }
}

extension RecipesListViewController: RecipesViewProtocol {
    func timeButtonPressed(color: String, image: String) {
        timeButton.backgroundColor = UIColor(named: color)
        timeButton.setTitleColor(.white, for: .normal)
        timeButton.setImage(UIImage(named: image), for: .normal)
        timeButton.setTitleColor(.black, for: .normal)
    }

    func caloriesButtonPressed(color: String, image: String) {
        caloriesButton.backgroundColor = UIColor(named: color)
        caloriesButton.setTitleColor(.white, for: .normal)
        caloriesButton.setImage(UIImage(named: image), for: .normal)
        caloriesButton.setTitleColor(.black, for: .normal)
    }

    func reloadTableView() {
        recipesTableView.reloadData()
    }
    
    func goToTheCategory() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func refreshData() {
        presenter?.getReceipts()
    }
}

extension RecipesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        presenter?.searchRecipes(text: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        presenter?.startSearch()
    }
}
