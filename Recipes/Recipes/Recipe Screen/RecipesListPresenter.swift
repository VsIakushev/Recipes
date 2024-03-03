//
//  RecipesListPresenter.swift
//  Recipes
//
//  Created by Vermut xxx on 02.03.2024.
//

import Foundation

protocol RecipesViewProtocol: AnyObject {
    func getRecipes(recipes: Category)
}

protocol RecipeProtocol: AnyObject {
//    var recipeCoordinator: RecipeCoordinator? { get set }
    func getUser()
}

/// Презентер экрана Рецептов

final class RecipeListPresenter {
    
    // MARK: - Private Properties

    private weak var view: RecipesViewProtocol?
//    weak var recipeCoordinator: RecipeCoordinator?
    private var category: Category
    
    // MARK: - Initializers
    
    init(view: RecipesViewProtocol, category: Category) {
        self.view = view
        self.category = category
    }
    
//    func onTap() {
//        recipeCoordinator?.pushProfile()
//    }
    
}
    extension RecipeListPresenter: RecipeProtocol {
        func getUser() {
//            let storage = Storage()
            view?.getRecipes(recipes: category)
        }
    }
