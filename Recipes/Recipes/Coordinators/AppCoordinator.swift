// AppCoordinator.swift
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

/// Координатор главный
final class AppCoordinator: BaseCoodinator {
    private var tabBarViewController: MainTabBarViewController?
    private var appBuilder = AppBuilder()

    override func start() {
        if "admin" == "admin" {
            toMain​()
        } else {
            t​oAuth​()
        }
    }

    private func toMain​() {
        tabBarViewController = MainTabBarViewController()
        /// Set Recipe
        let recipeModuleView = appBuilder.makeRecipeModule()
        let recipeCoordinator = RecipeCoordinator(rootController: recipeModuleView)
        recipeModuleView.presenter?.recipeCoordinator = recipeCoordinator
        add(coordinator: recipeCoordinator)

        /// Set Favorites
        let favoritesModuleView = appBuilder.makeFavoriteModule()
        let favoritesCoordinator = FavoritesCoordinator(rootController: favoritesModuleView)
        favoritesModuleView.presenter?.favoritesCoordinator = favoritesCoordinator
        add(coordinator: favoritesCoordinator)

        /// Set Profile
        let profileView = appBuilder.makeProfileModule()
        let profileCoordinator = ProfileCoordinator(rootController: profileView)
        profileView.presenter?.profileCoordinator = profileCoordinator
        add(coordinator: profileCoordinator)

        profileCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: recipeCoordinator)
            self?.remove(coordinator: favoritesCoordinator)
            self?.remove(coordinator: profileCoordinator)
            self?.tabBarViewController = nil
            self?.t​oAuth​()
        }

        tabBarViewController?.setViewControllers(
            [
                recipeCoordinator.rootController,
                favoritesCoordinator.rootController,
                profileCoordinator.rootController
            ],
            animated: false
        )
        setAsRoot​(​_​: tabBarViewController!)
    }

    private func t​oAuth​() {
        let authCoordinator = AuthCoordinator()
        authCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: authCoordinator)
            self?.toMain​()
        }
        add(coordinator: authCoordinator)
        authCoordinator.start()
    }
}
