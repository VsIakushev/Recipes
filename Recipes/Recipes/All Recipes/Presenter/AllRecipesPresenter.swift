// AllRecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
/// Протокол вью  всех рецептов
protocol RecipesViewProtocol: AnyObject {
    /// получение рецептов
    func getRecipes(recipes: [RecipeNetwork])
    /// переход на экран категорий
    func goToTheCategory()
    /// обновление таблицы
    func reloadTableView()
    /// нажатие на кнопку сортировка по времени
    func timeButtonPressed(color: String, image: String)
    /// нажатие на кнопку сортировка по калориям
    func caloriesButtonPressed(color: String, image: String)
    /// отсортировать рецепты
    func sortViewRecipes(recipes: [RecipeNetwork])
}

/// Протокол презентера
protocol RecipeProtocol: AnyObject {
    /// получить рецепты
    func getReceipts()
    /// переход к деталям рецепта
    func goToRecipeDetails(with recipe: RecipeNetwork)
    /// переход к категориям
    func goToCategory()
    /// поиск рецептов
    func searchRecipes(text: String)
    /// проверка поиска
    func checkSearch() -> [RecipeNetwork]
    /// начать поиск
    func startSearch()
    /// стоп поиск
    func stopSearch()
    /// отсортировать рецепты
    func sortRecipes(category: [RecipeNetwork])
    
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
    private var user: Recipe?
    private var isSearching = false
    private var searchNames: [RecipeNetwork] = []
//    private var recipes = Recipe.allRecipes
    private var recipes: [RecipeNetwork] = []
    private var sortedCalories = SortedCalories.none
    private var sortedTime = SortedTime.none
//    private var sorted = Recipe.allRecipes
    private var sorted: [RecipeNetwork] = []
    private var recipeDetailsPresenter: RecipeDetailsPresenter?
    private var networkService = NetworkService()
    var recipesNetwork: [RecipeNetwork] = []


    init(view: RecipesViewProtocol, coordinator: RecipeCoordinator) {
        self.view = view
        recipesCoordinator = coordinator
    }

    func buttonCaloriesChange(category: [RecipeNetwork]) {
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
    func buttonTimeChange(category: [RecipeNetwork]) {
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
    func goToRecipeDetails(with recipe: RecipeNetwork) {
        recipesCoordinator?.pushReceiptDetails(with: recipe)
    }
    
    func sortRecipes(category: [RecipeNetwork]) {
        var sorted = category
        
        let sortCalories: ((RecipeNetwork, RecipeNetwork) -> Bool)?
        switch sortedCalories {
        case .caloriesLow:
            sortCalories = { $0.calories ?? 0 < $1.calories ?? 0 }
        case .caloriesHigh:
            sortCalories = { $0.calories ?? 0 > $1.calories ?? 0 }
        default:
            sortCalories = nil
        }
        
        let sortTime: ((RecipeNetwork, RecipeNetwork) -> Bool)?
        switch sortedTime {
        case .timeLow:
            sortTime = { $0.cookingTime < $1.cookingTime }
        case .timeHigh:
            sortTime = { $0.cookingTime > $1.cookingTime }
        default:
            sortTime = nil
        }
        
        sorted = category.sorted { (lhs: RecipeNetwork, rhs: RecipeNetwork) -> Bool in
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
        
        view?.sortViewRecipes(recipes: sorted)
        self.sorted = sorted
    }
    
    func checkSearch() -> [RecipeNetwork] {
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
        searchNames = recipes.filter { $0.name.lowercased().contains(text.lowercased()) }
        view?.reloadTableView()
    }
    
    func goToCategory() {
        view?.goToTheCategory()
    }
    
    func getReceipts() {
        //        view?.getRecipes(recipes: Recipe.allRecipes)
        networkService.getRecipes(dishType: "Soup") { result in
            switch result {
            case let .success(recipes):
                self.recipesNetwork = recipes
                print(self.recipesNetwork.count, " рецептов в сетевом массиве")
                self.view?.getRecipes(recipes: recipes)
                DispatchQueue.main.async{
                    self.view?.reloadTableView()
                }

            case let .failure(error):
                print("Error fetching recipes: \(error)")
            }
        }
    }
}
