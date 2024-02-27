// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контейнер для проставления зависимостей и сборки модуля
class AppBuilder {
    func makeRecipeModule() -> RecipeViewController {
        let view = RecipeViewController()
        let recipePresenter = RecipePresenter(view: view)
        view.presenter = recipePresenter
        view.tabBarItem = UITabBarItem(title: "Recipe", image: UIImage(systemName: "homekit"), tag: 0)
        return view
    }

    func makeProfileModule() -> ProfileViewController {
        let view = ProfileViewController()
        let profilePresenter = ProfilePresenter(view: view)
        view.presenter = profilePresenter
        view.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "doc.plaintext"), tag: 1)
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

        /// Set Profile
        let profileView = appBuilder.makeProfileModule()
        let profileCoordinator = ProfileCoordinator(rootController: profileView)
        profileView.presenter?.profileCoordinator = profileCoordinator
        add(coordinator: profileCoordinator)

        profileCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: recipeCoordinator)
            self?.remove(coordinator: profileCoordinator)
            self?.tabBarViewController = nil
            self?.t​oAuth​()
        }

        tabBarViewController?.setViewControllers(
            [recipeCoordinator.rootController, profileCoordinator.rootController],
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