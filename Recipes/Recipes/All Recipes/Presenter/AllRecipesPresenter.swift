//
//  File.swift
//  Recipes
//
//  Created by Vermut xxx on 04.03.2024.
//

import Foundation
/// протокол вью  всех рецептов
protocol RecipesViewProtocol: AnyObject {
    func getRecipes(recipes: [Recipes])
    func setTitle(_ title: String)
    func goToTheCategory()
    func reloadTableView()
    func buttonTimeState(color: String, image: String)
    func buttonCaloriesState(color: String, image: String)
    func sortViewRecipes(recipes: [Recipes])

}
///протокол презентера
protocol RecipeProtocol: AnyObject {
    func getReceipts()
    func goToRecipeDetails()
    func goToCategory()
    func getCategoryTitle()
    func searchRecipes(text: String)
    func checkSearch() -> [Recipes]
    func startSearch()
    func stopSearch()
    func sortRecipes(category: [Recipes])


}
/// презентер всех рецептов
final class AllRecipesPresenter {
    private weak var view: RecipesViewProtocol?
     weak var recipesCoordinator: RecipeCoordinator?
    private var user: Recipes?
    private var isSearching = false
    private var searchNames: [Recipes] = []
    private var recipes = Recipes.allRecipes
    private var sortedCalories = SortedCalories.none
    private var sortedTime = SortedTime.none
    var sorted = Recipes.allRecipes


    init(view: RecipesViewProtocol, coordinator: RecipeCoordinator) {
        self.view = view
        self.recipesCoordinator = coordinator
    }
    
    func buttonCaloriesChange(category: [Recipes]) {
            if sortedCalories == .none {
                sortedCalories = .caloriesLow
                view?.buttonCaloriesState(color: "background01", image: "filterLow")
                sortRecipes(category: category)
            } else if sortedCalories == .caloriesLow {
                sortedCalories = .caloriesHigh
                view?.buttonCaloriesState(color: "background01", image: "filterHigh")
                sortRecipes(category: category)
            } else if sortedCalories == .caloriesHigh {
                sortedCalories = .none
                view?.buttonCaloriesState(color: "background06", image: "filterIcon")
                sortRecipes(category: category)
            }
        }

        /// Метод меняющий состояниие кнопки таймера
        func buttonTimeChange(category: [Recipes]) {
            if sortedTime == .none {
                sortedTime = .timeLow
                view?.buttonTimeState(color: "background01", image: "filterLow")
                sortRecipes(category: category)
            } else if sortedTime == .timeLow {
                view?.buttonTimeState(color: "background01", image: "filterHigh")
                sortedTime = .timeHigh
                sortRecipes(category: category)
            } else if sortedTime == .timeHigh {
                sortedTime = .none
                view?.buttonTimeState(color: "background06", image: "filterIcon")
                sortRecipes(category: category)
            }
        }
}

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
    
    func getCategoryTitle() {
//        view?.setTitle(<#T##title: String##String#>)
    }
    
    func getReceipts() {
        let storage = Storage()
        view?.getRecipes(recipes: storage.fish)
        //view?.setTitle(title)
    }
    
    func goToRecipeDetails() {
        recipesCoordinator?.pushReceiptDetails()
    }
}
