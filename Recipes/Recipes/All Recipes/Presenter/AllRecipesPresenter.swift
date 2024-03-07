// AllRecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол вью  всех рецептов
protocol RecipesViewProtocol: AnyObject {
    /// получение рецептов
    func getRecipes(recipes: [Recipes])
    /// переход на экран категорий
    func goToTheCategory()
    /// обновление таблицы
    func reloadTableView()
    /// нажатие на кнопку сортировка по времени
    func timeButtonPressed(color: String, image: String)
    /// нажатие на кнопку сортировка по калориям
    func caloriesButtonPressed(color: String, image: String)
    /// отсортировать рецепты
    func sortViewRecipes(recipes: [Recipes])
}

/// Протокол презентера
protocol RecipeProtocol: AnyObject {
    /// получить рецепты
    func getReceipts()
    /// переход к деталям рецепта
    func goToRecipeDetails()
    /// переход к категориям
    func goToCategory()
    /// поиск рецептов
    func searchRecipes(text: String)
    /// проверка поиска
    func checkSearch() -> [Recipes]
    /// начать поиск
    func startSearch()
    /// стоп поиск
    func stopSearch()
    /// отсортировать рецепты
    func sortRecipes(category: [Recipes])
}

final class AllRecipesPresenter {
    private enum Constants {
        static let background01 = "background01"
        static let filterLow = "filterLow"
        static let filterHigh = "filterHigh"
        static let background06 = "background06"
        static let filterIcon = "filterIcon"
    }

    private weak var view: RecipesViewProtocol?

    private weak var recipesCoordinator: RecipeCoordinator?
    private var user: Recipes?
    private var isSearching = false
    private var searchNames: [Recipes] = []
    private var recipes = Recipes.allRecipes
    private var sortedCalories = SortedCalories.none
    private var sortedTime = SortedTime.none
    var sorted = Recipes.allRecipes

    init(view: RecipesViewProtocol, coordinator: RecipeCoordinator) {
        self.view = view
        recipesCoordinator = coordinator
    }

    func buttonCaloriesChange(category: [Recipes]) {
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
    func buttonTimeChange(category: [Recipes]) {
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
    func sortRecipes(category: [Recipes]) {
        let defaultRecipes = Recipes.allRecipes
        var sorted = category

        let sortCalories: ((Recipes, Recipes) -> Bool)?
        switch sortedCalories {
        case .caloriesLow:
            sortCalories = { Int($0.caloriesTitle) ?? 0 < Int($1.caloriesTitle) ?? 0 }
        case .caloriesHigh:
            sortCalories = { Int($0.caloriesTitle) ?? 0 > Int($1.caloriesTitle) ?? 0 }
        default:
            sortCalories = nil
        }

        let sortTime: ((Recipes, Recipes) -> Bool)?
        switch sortedTime {
        case .timeLow:
            sortTime = { Int($0.cookingTimeTitle) ?? 0 < Int($1.cookingTimeTitle) ?? 0 }
        case .timeHigh:
            sortTime = { Int($0.cookingTimeTitle) ?? 0 > Int($1.cookingTimeTitle) ?? 0 }
        default:
            sortTime = nil
        }

        sorted = category.sorted { lhs, rhs in
            if let sortCalories = sortCalories, let sortTime = sortTime {
                if lhs.caloriesTitle == rhs.caloriesTitle {
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

        view?.sortViewRecipes(recipes: sorted)
        self.sorted = sorted
    }

    func checkSearch() -> [Recipes] {
        if isSearching {
            return searchNames
        } else {
            return sorted
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
        searchNames = recipes.filter { $0.titleRecipies.lowercased().contains(text.lowercased()) }
        view?.reloadTableView()
    }

    func goToCategory() {
        view?.goToTheCategory()
    }

    func getReceipts() {
        let storage = Storage()
        view?.getRecipes(recipes: storage.fishes)
    }

    func goToRecipeDetails() {
        recipesCoordinator?.pushReceiptDetails()
    }
}
