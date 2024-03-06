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

}
/// презентер всех рецептов
final class AllRecipesPresenter {
    private weak var view: RecipesViewProtocol?
     weak var recipesCoordinator: RecipeCoordinator?
    private var user: Recipes?
    private var isSearching = false
    private var searchNames: [Recipes] = []
    private var recipes = Recipes.allRecipes

    init(view: RecipesViewProtocol, coordinator: RecipeCoordinator) {
        self.view = view
        self.recipesCoordinator = coordinator
    }
}

extension AllRecipesPresenter: RecipeProtocol {
    func checkSearch() -> [Recipes] {
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
