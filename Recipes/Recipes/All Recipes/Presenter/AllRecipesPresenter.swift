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
    func getUser()
}
/// презентер всех рецептов
final class AllRecipesPresenter {
    private weak var view: RecipesViewProtocol?
    private weak var recipesCoordinator: RecipeCoordinator?
    private var user: Recipes?

    init(view: RecipesViewProtocol) {
        self.view = view
    }
}

extension AllRecipesPresenter: RecipeProtocol {
    func getUser() {
        let storage = Storage()
        view?.getRecipes(recipes: storage.fish)
    }
}
