// RecipeCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор рецептов
final class RecipeCoordinator: BaseCoodinator {
    var rootController: UINavigationController!
    var onFinishFlow: VoidHandler?

    private var appBuilder = AppBuilder()

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(rootViewController: view)
    }

    func pushCategoryDetails(for category: String) {
        let categoryViewController = appBuilder.makeRecipesListModule(coordinator: self)
        rootController.pushViewController(categoryViewController, animated: true)
        categoryViewController.categoryTitle = category
    }

    func closeRecipeDetails() {
        rootController.popViewController(animated: true)
    }

    func pushProfile() {
        let profileViewController = ProfileViewController()
        rootController.pushViewController(profileViewController, animated: true)
    }

    func pushReceiptDetails() {
        let recipeDetailViewController = appBuilder.makeRecipeDetailsModule(coordinator: self)
        rootController.pushViewController(recipeDetailViewController, animated: true)
    }
}
