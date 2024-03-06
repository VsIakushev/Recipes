//
//  RecipesListViewController.swift
//  Recipes
//
//  Created by Vermut xxx on 04.03.2024.
//

import UIKit

/// Таблица  с рецептами
final class RecipesListViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let cellIdendefire = "CellRecipes"
        static let skeletonCellIdIdentifier = "CellSkeleton"
        static let backBarButtonImage = UIImage(systemName: "arrow.backward")
        static let filterIconImage = UIImage(named: "filterIcon")
        static let titleNavigation = "Fish"
        static let serchPlaceholder = "Search recipes"
        static let caloriesButtonTitle = "Calories"
        static let timeButtonTitle = "Time"
    }

    // MARK: - Visual Components

    private lazy var recipesTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(RecipesCell.self, forCellReuseIdentifier: Constants.cellIdendefire)
        table.register(SkeletonRecipesCell.self, forCellReuseIdentifier: Constants.skeletonCellIdIdentifier)
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Verdana-Bold", size: 28)
            label.textColor = .black
            return label
        }()

    private lazy var backButton: UIButton = {
        let view = UIView()
        let button = UIButton()
        button.setImage(UIImage(named: "arrowBack"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()


    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = Constants.serchPlaceholder
        search.backgroundImage = UIImage()
        return search
    }()

    let caloriesButton = UIButton()
    let timeButton = UIButton()

    // MARK: - Public Properties

    var recipes: [Recipes] = []
    
    var categoryTitle: String = ""

    var presenter: AllRecipesPresenter?
    
    // MARK: - Private Properties
    
    private var stateShimer = StateShimer.loading

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showSkeleton()
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = categoryTitle

    }

    // MARK: - Private Methods

    func setupUI() {
        presenter?.getReceipts()
        //addTapGestureToHideKeyboard()
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(recipesTableView)
        makeFilterButton(button: caloriesButton, title: Constants.caloriesButtonTitle)
        makeFilterButton(button: timeButton, title: Constants.timeButtonTitle)
//        configureNavigation()
        makeAnchor()
        
        navigationItem.leftBarButtonItems = [
                    UIBarButtonItem(customView: backButton),
                    UIBarButtonItem(customView: titleLabel)
                ]
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
        button.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        view.addSubview(button)
    }

    private func makeAnchor() {
        makeAnchorsSearchBar()
        setupAnchorsCaloriesButton()
        setupAnchorsTimeButton()
        makeTableViewAnchor()
    }

    @objc private func timeButtonTapped(seder: UIButton) {
        seder.backgroundColor = UIColor.background01()
        seder.setTitleColor(.white, for: .normal)
        seder.imageView?.transform = seder.imageView?.transform.rotated(by: .pi) ?? CGAffineTransform()
        seder.setTitleColor(.black, for: .normal)
    }
    
    @objc private func backButtonTapped() {
        presenter?.goToCategory()
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
    
    private func showSkeleton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.stateShimer = .done
            self.recipesTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate

extension RecipesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        presenter?.goToRecipeDetails()
        }
}

// MARK: - UITableViewDataSource

extension RecipesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch stateShimer {
        case .loading:
            return SkeletonRecipesCell()
        case .done:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.cellIdendefire,
                for: indexPath
            ) as? RecipesCell
            else { return UITableViewCell() }
            cell.configure(with: recipes[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }
}

extension RecipesListViewController: RecipesViewProtocol {
    func goToTheCategory() {
        navigationController?.popViewController(animated: true)

    }
    
    func getRecipes(recipes: [Recipes]) {
        self.recipes = recipes
        recipesTableView.reloadData()
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = categoryTitle
    }

}
