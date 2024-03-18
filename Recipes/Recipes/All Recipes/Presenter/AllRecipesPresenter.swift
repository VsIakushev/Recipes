// AllRecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью  всех рецептов
protocol RecipesViewProtocol: AnyObject {
    /// переход на экран категорий
    func goToTheCategory()
    /// обновление таблицы
    func reloadTableView()
    /// нажатие на кнопку сортировка по времени
    func timeButtonPressed(color: String, image: String)
    /// нажатие на кнопку сортировка по калориям
    func caloriesButtonPressed(color: String, image: String)
    /// Обновление состояния вью
    func updateState()
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
    /// отсортировать рецепты
    func sortRecipes(recipes: [Recipe])
    /// Название категории
    var categoryTitle: String { get }
    /// Состояние загрузки данных
    var state: ViewState<[Recipe]> { get }
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
    
//MARK: - Public Properties
    
    var state: ViewState<[Recipe]> = .loading {
        didSet {
            view?.updateState()
        }
    }
    
    private weak var view: RecipesViewProtocol?
    private weak var recipesCoordinator: RecipeCoordinator?
    private var isSearching = false
    private var sortedCalories = SortedCalories.none
    private var sortedTime = SortedTime.none
    private var originalRecipes: [Recipe] = []
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

    func buttonCaloriesChange() {
        guard case .data(let recipes) = state else { return }
        switch sortedCalories {
        case .none:
            sortedCalories = .caloriesLow
            view?.caloriesButtonPressed(color: Constants.background01, image: Constants.filterLow)
        case .caloriesLow:
            sortedCalories = .caloriesHigh
            view?.caloriesButtonPressed(color: Constants.background01, image: Constants.filterHigh)
        case .caloriesHigh:
            sortedCalories = .none
            view?.caloriesButtonPressed(color: Constants.background06, image: Constants.filterIcon)
        }
        sortRecipes(recipes: recipes)
    }

    /// Метод меняющий состояниие кнопки таймера
    func buttonTimeChange(recipes: [Recipe]) {
        if sortedTime == .none {
            sortedTime = .timeLow
            view?.timeButtonPressed(color: Constants.background01, image: Constants.filterLow)
            sortRecipes(recipes: recipes)
        } else if sortedTime == .timeLow {
            view?.timeButtonPressed(color: Constants.background01, image: Constants.filterHigh)
            sortedTime = .timeHigh
            sortRecipes(recipes: recipes)
        } else if sortedTime == .timeHigh {
            sortedTime = .none
            view?.timeButtonPressed(color: Constants.background06, image: Constants.filterIcon)
            sortRecipes(recipes: recipes)
        }
    }
    func buttonTimeChange() {
        guard case .data(let recipes) = state else { return }
        switch sortedTime {
        case .none:
            sortedTime = .timeLow
            view?.timeButtonPressed(color: Constants.background01, image: Constants.filterLow)
        case .timeLow:
            sortedTime = .timeHigh
            view?.timeButtonPressed(color: Constants.background01, image: Constants.filterHigh)
        case .timeHigh:
            sortedTime = .none
            view?.timeButtonPressed(color: Constants.background06, image: Constants.filterIcon)
        }
        sortRecipes(recipes: recipes)
    }
}

// MARK: AllRecipesPresenter + RecipeProtocol

extension AllRecipesPresenter: RecipeProtocol {
    func goToRecipeDetails(with recipe: Recipe) {
        recipesCoordinator?.pushReceiptDetails(with: recipe)
    }

    func sortRecipes(recipes: [Recipe]) {
        var sorted: [Recipe]

        if sortedCalories == .none, sortedTime == .none {
            sorted = recipes.shuffled()
        } else {
            sorted = recipes

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

            sorted = recipes.sorted { (lhs: Recipe, rhs: Recipe) -> Bool in
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

        state = .data(sorted)
    }

   
    func searchRecipes(text: String) {
        if text.isEmpty {
            isSearching = false
            recipes = originalRecipes
        } else {
            isSearching = true
            getReceipts(searchString: text)
        }
        view?.reloadTableView()
    }

    func checkSearch() -> [Recipe] {
        return isSearching ? recipes : originalRecipes
    }

    func startSearch() {
        isSearching = true
    }


    func goToCategory() {
        view?.goToTheCategory()
    }

    func getReceipts(searchString: String? = nil) {
        state = .loading

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
//                    self.state = .data(recipes)
                    self.state = !recipes.isEmpty ? .data(recipes) : .noData

                case let .failure(error):
                    self.state = .error(error)
                    print("Error fetching recipes: \(error)")
                }
            }
        }
    }
}
