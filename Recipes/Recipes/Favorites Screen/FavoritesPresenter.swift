// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

///протокол вью
protocol FavoritesViewControllerProtocol: AnyObject {
    /// показать плашку нет избранных
    func setEmptyState()
    /// показать таблицу
    func setNonEmptyState()
    /// получить избранные рецепты
    func getFavRecipes()
    /// рецепты
    var recipes: [Recipes] { get set }
}
///протокол презентера
protocol FavoritesPresenterProtocol {
    var favoritesCoordinator: FavoritesCoordinator? { get set }
    /// проверка на сустой массив избранных
    func checkIfFavouritesEmpty()
    /// получить количество избранных в масиве
    func getFavouritesCount() -> Int
    /// получить избранные рецепты
    func getFavourites() -> [Recipes]
    /// удаление из избранных
    func removeFromFavourites(recipeIndex: Int)
    /// переход к экрану детального рецепта
    func goToRecipeDetails()

}

/// Презентер экрана Избранных рецептов
final class FavoritesPresenter {
    
    // MARK: - Private Properties
    
    private weak var view: FavoritesViewControllerProtocol?
    
    private var recipes = Recipes.favoritesRecipes
    
    // MARK: - Public Properties
    
    weak var favoritesCoordinator: FavoritesCoordinator?
    
    // MARK: - Initializers
    
    init(view: FavoritesViewControllerProtocol) {
        self.view = view
    }
}
    // MARK: - FavoritesPresenter + FavoritesPresenterProtocol

    extension FavoritesPresenter: FavoritesPresenterProtocol {
    
    private  func onTap() {
        favoritesCoordinator?.pushRecipe()
    }

    private func onLogOut() {
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
