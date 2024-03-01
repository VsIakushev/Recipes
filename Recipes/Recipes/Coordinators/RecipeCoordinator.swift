// RecipeCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор рецептов
final class RecipeCoordinator: BaseCoodinator {
    var rootController: UINavigationController
    var onFinishFlow: (() -> Void)?

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    func pushProfile() {
        let profileVC = ProfileViewController()
        rootController.pushViewController(profileVC, animated: true)
    }
}
