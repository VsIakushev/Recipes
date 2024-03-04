//
//  File.swift
//  Recipes
//
//  Created by Vermut xxx on 04.03.2024.
//

import Foundation
/// протокол всех рецептов
protocol RecipesViewProtocol: AnyObject {
    func getRecipes(recipes: [Recipes])
}

protocol RecipeProtocol: AnyObject {
    func getReceipts()
    func goToRecipeDetails()
}
/// презентер всех рецептов
final class AllRecipesPresenter {
    private weak var view: RecipesViewProtocol?
     weak var recipesCoordinator: RecipeCoordinator?
    private var user: Recipes?

    init(view: RecipesViewProtocol, coordinator: RecipeCoordinator) {
        self.view = view
        self.recipesCoordinator = coordinator
    }
}

extension AllRecipesPresenter: RecipeProtocol {
    func getReceipts() {
        let storage = Storage()
        view?.getRecipes(recipes: storage.fish)
    }
    
    func goToRecipeDetails() {
        recipesCoordinator?.pushReceiptDetails()
    }
}
