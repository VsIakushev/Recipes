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

    func pushCategoryDetails(for category: RecipeType, categoryName: String) {
        let categoryViewController = appBuilder.makeRecipesListModule(
            coordinator: self,
            categoryTitle: categoryName,
            category: category
        )
        rootController.pushViewController(categoryViewController, animated: true)
        categoryViewController.categoryTitle = categoryName
    }

    func closeRecipeDetails() {
        rootController.popViewController(animated: true)
    }

    func pushProfile() {
        let profileViewController = ProfileViewController()
        rootController.pushViewController(profileViewController, animated: true)
    }

    func pushReceiptDetails(with recipe: Recipe) {
        let recipeDetailViewController = appBuilder.makeRecipeDetailsModule(coordinator: self, uri: recipe.uri)
        recipeDetailViewController.recipe = recipe
        rootController.pushViewController(recipeDetailViewController, animated: true)
    }
}
