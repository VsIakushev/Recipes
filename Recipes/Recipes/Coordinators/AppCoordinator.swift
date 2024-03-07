// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор главный
final class AppCoordinator: BaseCoodinator {
    private var tabBarViewController: MainTabBarViewController?
    private var appBuilder = AppBuilder()

    // MARK: - Life Cycles

    override func start() {
        if "admin" == "admin" {
            t​oAuth​()
        } else {
            toMain​()
        }
    }

    // MARK: - Private Methods

    private func toMain​() {
        tabBarViewController = MainTabBarViewController()
        /// Set Recipe
        let recipeCoordinator = RecipeCoordinator()
        let recipeModuleView = appBuilder.makeRecipeModule(coordinator: recipeCoordinator)
        recipeCoordinator.setRootViewController(view: recipeModuleView)
        add(coordinator: recipeCoordinator)

        /// Set Favorites
        let favoritesCoordinator = FavoritesCoordinator()

        let favoritesModuleView = appBuilder.makeFavoriteModule(coordinator: favoritesCoordinator)
        favoritesCoordinator.setRootViewController(view: favoritesModuleView)
        add(coordinator: favoritesCoordinator)

        /// Set Profile
        let profileCoordinator = ProfileCoordinator()
        let profileView = appBuilder.makeProfileModule(coordinator: profileCoordinator)
        profileCoordinator.setRootViewController(view: profileView)
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
