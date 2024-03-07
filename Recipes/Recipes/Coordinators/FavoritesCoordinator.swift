// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор избранных рецептов
final class FavoritesCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var rootController: UINavigationController
    var onFinishFlow: VoidHandler?
    let recipeCoordinator = RecipeCoordinator()

    private var appBuilder = AppBuilder()

    // MARK: - Initializers

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    // MARK: - Public Methods

    func logOut() {
        onFinishFlow?()
    }

    func pushRecipe() {
        let recipeViewController = RecipeViewController()
        rootController.pushViewController(recipeViewController, animated: true)
    }

    func pushReceiptDetails() {
        let recipeDetailVC = appBuilder.makeRecipeDetailsModule(coordinator: recipeCoordinator)
        rootController.pushViewController(recipeDetailVC, animated: true)
    }
}
