// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

protocol FavoritesViewControllerProtocol: AnyObject {
    /// метод установки вью в состояние - нет избранных рецептов
    func setEmptyState()
    /// метод установки вью в состояние - есть избранные рецепты
    func setNonEmptyState()
    
    func getFavRecipes()
    
    var recipes: [Recipes] { get set }
}

protocol FavoritesPresenterProtocol {
    var favoritesCoordinator: FavoritesCoordinator? { get set }
    
    func checkIfFavouritesEmpty()
    
    func getFavouritesCount() -> Int

    func getFavourites() -> [Recipes]
    
    func removeFromFavourites(recipeIndex: Int)
    
    func goToRecipeDetails()

}

/// Презентер экрана Избранных рецептов
final class FavoritesPresenter: FavoritesPresenterProtocol {
    
    weak var favoritesCoordinator: FavoritesCoordinator?

    private weak var view: FavoritesViewControllerProtocol?
    
    var recipes = Recipes.favoritesRecipes

    init(view: FavoritesViewControllerProtocol) {
        self.view = view
    }

    func onTap() {
        favoritesCoordinator?.pushRecipe()
    }

    func onLogOut() {
        favoritesCoordinator?.logOut()
    }

    func removeFromFavourites(recipeIndex: Int) {
            let recipe = Recipes.favoritesRecipes.remove(at: recipeIndex)
            view?.recipes.remove(at: recipeIndex)
        
            for var item in Recipes.allRecipes where item == recipe {
                item.isFavorite = false
            }
        }
    
    func getFavourites() -> [Recipes] {
        return recipes
        
        }

    
    func checkIfFavouritesEmpty() {
        if getFavouritesCount() == 0 {
                view?.setEmptyState()
            } else {
                view?.setNonEmptyState()
            }
        }
    
    func getFavouritesCount() -> Int {
        view?.recipes.count ?? 0
    }
    
    func goToRecipeDetails() {
        favoritesCoordinator?.pushReceiptDetails()
    }
}
