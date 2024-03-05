// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

protocol FavoritesViewControllerProtocol: AnyObject {}

protocol FavoritesPresenterProtocol {
    var favoritesCoordinator: FavoritesCoordinator? { get set }
}

/// Презентер экрана Избранных рецептов
final class FavoritesPresenter: FavoritesPresenterProtocol {
    weak var favoritesCoordinator: FavoritesCoordinator?

    private weak var view: FavoritesViewControllerProtocol?

    init(view: FavoritesViewControllerProtocol) {
        self.view = view
    }

    func onTap() {
        favoritesCoordinator?.pushRecipe()
    }

    func onLogOut() {
        favoritesCoordinator?.logOut()
    }
    
//    func goToRecipeDetails() {
//        favoritesCoordinator?.pushReceiptDetails()
//    }

}
