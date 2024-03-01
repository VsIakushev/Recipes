// RecipeCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор рецептов
final class RecipeCoordinator: BaseCoodinator {
    var rootController: UINavigationController!
    var onFinishFlow: (() -> Void)?

//    init(rootController: UIViewController) {
//
//    }

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(rootViewController: view)
    }

    func pushCategoryDetails(for category: String) {
        print("Переход на экран категории: \(category)")
        // TODO: Расскомментировать когда Евгений реализует экран categoryDetailViewController
        // let categoryViewController = categoryDetailViewController(for category: category)
        // rootController.pushViewController(categoryViewController, animated: true)
    }

    func pushProfile() {
        let profileVC = ProfileViewController()
        rootController.pushViewController(profileVC, animated: true)
    }
}
