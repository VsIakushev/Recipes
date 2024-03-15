// AllRecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью  всех рецептов
protocol RecipesViewProtocol: AnyObject {
    /// получение рецептов
    func getRecipes(recipes: [Recipe])
    /// переход на экран категорий
    func goToTheCategory()
    /// обновление таблицы
    func reloadTableView()
    /// нажатие на кнопку сортировка по времени
    func timeButtonPressed(color: String, image: String)
    /// нажатие на кнопку сортировка по калориям
    func caloriesButtonPressed(color: String, image: String)
    /// отсортировать рецепты
    func sortViewRecipes(recipes: [Recipe])
}

/// Протокол презентера
protocol RecipeProtocol: AnyObject {
    /// получить рецепты
    func getReceipts(searchString: String?)
    /// переход к деталям рецепта
    func goToRecipeDetails(with recipe: Recipe)
    /// переход к категориям
    func goToCategory()
    /// поиск рецептов
    func searchRecipes(text: String)
    /// проверка поиска
    func checkSearch() -> [Recipe]
    /// начать поиск
    func startSearch()
    /// стоп поиск
    func stopSearch()
    /// отсортировать рецепты
    func sortRecipes(category: [Recipe])
    /// Название категории
    var categoryTitle: String { get }
}

final class AllRecipesPresenter {
    private enum Constants {
        static let background01 = "background01"
        static let filterLow = "filterLow"
        static let filterHigh = "filterHigh"
        static let background06 = "background06"
        static let filterIcon = "filterIcon"
        static let vegetarianText = "vegetarian"
    }

    private weak var view: RecipesViewProtocol?

    private weak var recipesCoordinator: RecipeCoordinator?
    private var user: Recipe?
    private var isSearching = false
    private var searchNames: [Recipe] = []
    private var sortedCalories = SortedCalories.none
    private var sortedTime = SortedTime.none
    private var sorted: [Recipe] = []
    private var recipeDetailsPresenter: RecipeDetailsPresenter?
    private var networkService = NetworkService()
    var recipes: [Recipe] = []
    var categoryTitle: String = ""
    private var category: RecipeType

    init(view: RecipesViewProtocol, coordinator: RecipeCoordinator, categoryTitle: String, category: RecipeType) {
        self.view = view
        self.categoryTitle = categoryTitle
        self.category = category
        recipesCoordinator = coordinator
    }

    func buttonCaloriesChange(category: [Recipe]) {
        if sortedCalories == .none {
            sortedCalories = .caloriesLow
            view?.caloriesButtonPressed(color: Constants.background01, image: Constants.filterLow)
            sortRecipes(category: category)
        } else if sortedCalories == .caloriesLow {
            sortedCalories = .caloriesHigh
            view?.caloriesButtonPressed(color: Constants.background01, image: Constants.filterHigh)
            sortRecipes(category: category)
        } else if sortedCalories == .caloriesHigh {
            sortedCalories = .none
            view?.caloriesButtonPressed(color: Constants.background06, image: Constants.filterIcon)
            sortRecipes(category: category)
        }
    }

    /// Метод меняющий состояниие кнопки таймера
    func buttonTimeChange(category: [Recipe]) {
        if sortedTime == .none {
            sortedTime = .timeLow
            view?.timeButtonPressed(color: Constants.background01, image: Constants.filterLow)
            sortRecipes(category: category)
        } else if sortedTime == .timeLow {
            view?.timeButtonPressed(color: Constants.background01, image: Constants.filterHigh)
            sortedTime = .timeHigh
            sortRecipes(category: category)
        } else if sortedTime == .timeHigh {
            sortedTime = .none
            view?.timeButtonPressed(color: Constants.background06, image: Constants.filterIcon)
            sortRecipes(category: category)
        }
    }
}

// MARK: AllRecipesPresenter + RecipeProtocol

extension AllRecipesPresenter: RecipeProtocol {
    func goToRecipeDetails(with recipe: Recipe) {
        recipesCoordinator?.pushReceiptDetails(with: recipe)
    }

    func sortRecipes(category: [Recipe]) {
        var sorted: [Recipe]

        if sortedCalories == .none, sortedTime == .none {
            sorted = category.shuffled()
        } else {
            sorted = category

            let sortCalories: ((Recipe, Recipe) -> Bool)?
            switch sortedCalories {
            case .caloriesLow:
                sortCalories = { $0.calories ?? 0 < $1.calories ?? 0 }
            case .caloriesHigh:
                sortCalories = { $0.calories ?? 0 > $1.calories ?? 0 }
            default:
                sortCalories = nil
            }

            let sortTime: ((Recipe, Recipe) -> Bool)?
            switch sortedTime {
            case .timeLow:
                sortTime = { $0.cookingTime < $1.cookingTime }
            case .timeHigh:
                sortTime = { $0.cookingTime > $1.cookingTime }
            default:
                sortTime = nil
            }

            sorted = category.sorted { (lhs: Recipe, rhs: Recipe) -> Bool in
                if let sortCalories = sortCalories, let sortTime = sortTime {
                    if lhs.calories == rhs.calories {
                        return sortTime(lhs, rhs)
                    } else {
                        return sortCalories(lhs, rhs)
                    }
                } else if let sortCalories = sortCalories {
                    return sortCalories(lhs, rhs)
                } else if let sortTime = sortTime {
                    return sortTime(lhs, rhs)
                }
                return false
            }
        }

        view?.sortViewRecipes(recipes: sorted)
        self.sorted = sorted
    }

    func checkSearch() -> [Recipe] {
        if isSearching {
            return searchNames
        } else {
            return recipes
        }
    }

    func startSearch() {
        isSearching = true
    }

    func stopSearch() {
        isSearching = false
    }

    func searchRecipes(text: String) {
        guard !text.isEmpty else {
            isSearching = false
            searchNames = []
            view?.reloadTableView()
            return
        }

        isSearching = true
        searchNames = recipes.filter { $0.name.lowercased().contains(text.lowercased()) }
        view?.reloadTableView()
    }

    func goToCategory() {
        view?.goToTheCategory()
    }

    func getReceipts(searchString: String? = nil) {
        var health: String?

        if category == .sideDish {
            health = Constants.vegetarianText
        }

        if let searchString = searchString {
            var query = category.rawValue
            if !query.isEmpty {
                query.append(" ")
            }
            query.append(searchString)
            fetchRecipes(health: health, query: query)
        } else {
            fetchRecipes(health: health, query: category.rawValue)
        }
    }

    private func fetchRecipes(health: String?, query: String?) {
        networkService.getRecipes(dishType: category, health: health, query: query) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(recipes):
                    self.recipes = recipes
                    self.view?.getRecipes(recipes: recipes)
                    DispatchQueue.main.async {
                        self.view?.reloadTableView()
                    }

                case let .failure(error):
                    print("Error fetching recipes: \(error)")
                }
            }
        }

        networkService.getRecipes(dishType: category, health: health, query: query) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                switch result {
                case let .success(recipes):
                    self.recipes = recipes
                    self.view?.getRecipes(recipes: recipes)
                    DispatchQueue.main.async {
                        self.view?.reloadTableView()
                    }

                case let .failure(error):
                    print("Error fetching recipes: \(error)")
                }
            }
        }
    }
}
