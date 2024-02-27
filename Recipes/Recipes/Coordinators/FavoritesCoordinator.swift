// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор избранных рецептов
final class FavoritesCoordinator: BaseCoodinator {
    var rootController: UINavigationController
    var onFinishFlow: (() -> Void)?

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    func logOut() {
        onFinishFlow?()
    }

    func pushRecipe() {
        let recipeViewController = RecipeViewController()
        rootController.pushViewController(recipeViewController, animated: true)
    }
}
