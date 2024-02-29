// AppBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контейнер для проставления зависимостей и сборки модуля
class AppBuilder {
    func makeRecipeModule() -> RecipeViewController {
        let view = RecipeViewController()
        let recipePresenter = RecipePresenter(view: view)
        view.presenter = recipePresenter
        view.tabBarItem = UITabBarItem(
            title: "Recipes",
            image: UIImage(named: "muffin"),
            selectedImage: UIImage(named: "muffin.fill")
        )
        return view
    }

    func makeFavoriteModule() -> FavoritesViewController {
        let view = FavoritesViewController()
        let favoritesPresenter = FavoritesPresenter(view: view)
        view.presenter = favoritesPresenter
        view.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(named: "favorites"),
            selectedImage: UIImage(named: "favorites.fill")
        )
        return view
    }

    func makeProfileModule() -> ProfileViewController {
        let view = ProfileViewController()
        let profilePresenter = ProfilePresenter(view: view)
        view.presenter = profilePresenter
        view.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "smile"),
            selectedImage: UIImage(named: "smile.fill")
        )
        return view
    }
}
