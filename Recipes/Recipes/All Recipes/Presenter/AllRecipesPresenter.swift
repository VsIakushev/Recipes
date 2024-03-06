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
}
///протокол презентера
protocol RecipeProtocol: AnyObject {
    func getReceipts()
    func goToRecipeDetails()
    func goToCategory()
    func getCategoryTitle()
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
