// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор избранных рецептов
final class FavoritesCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var rootController: UINavigationController!
    var onFinishFlow: VoidHandler?
    let recipeCoordinator = RecipeCoordinator()
    private var appBuilder = AppBuilder()

    // MARK: - Public Methods

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(rootViewController: view)
    }

    func logOut() {
        onFinishFlow?()
    }

    func pushRecipe() {
        let recipeViewController = RecipeViewController()
        rootController.pushViewController(recipeViewController, animated: true)
    }

    func pushReceiptDetails(recipe: Recipe) {
        let recipeDetailVC = appBuilder.makeRecipeDetailsModule(coordinator: recipeCoordinator, uri: recipe.uri)
        rootController.pushViewController(recipeDetailVC, animated: true)
    }
}
