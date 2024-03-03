// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контейнер для проставления зависимостей и сборки модуля
class AppBuilder {
    func makeRecipeModule(coordinator: RecipeCoordinator) -> RecipeViewController {
        let view = RecipeViewController()
        let recipePresenter = RecipePresenter(view: view, coordinator: coordinator)
        view.presenter = recipePresenter
        view.setupUI()
        return view
    }
    
    func makeRecipeDetailsModule(coordinator: RecipeCoordinator) -> RecipeDetailsViewController {
        let view = RecipeDetailsViewController()
        let recipeDetailsPresenter = RecipeDetailsPresenter(view: view, coordinator: coordinator)
        view.presenter = recipeDetailsPresenter
        view.setupUI()
        return view
    }

    func makeFavoriteModule() -> FavoritesViewController {
        let view = FavoritesViewController()
        let favoritesPresenter = FavoritesPresenter(view: view)
        view.presenter = favoritesPresenter
        view.setupUI()
        return view
    }

    func makeProfileModule(coordinator: ProfileCoordinator) -> ProfileViewController {
        let view = ProfileViewController()
        let profilePresenter = ProfilePresenter(view: view, coordinator: coordinator)
        view.presenter = profilePresenter
        view.setupUI()
        return view
    }
}
