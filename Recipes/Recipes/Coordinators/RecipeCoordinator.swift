// RecipeCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор рецептов
final class RecipeCoordinator: BaseCoodinator {
    var rootController: UINavigationController!
    var onFinishFlow: (() -> Void)?
    
    private var appBuilder = AppBuilder()

//    init(rootController: UIViewController) {
//
//    }

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(rootViewController: view)
    }

    func pushCategoryDetails(for category: String) {
        
        // временный переход на RecipeDetailView, пока делаю этот экран
        // TODO: Этот переход должен быть с экрана категорий, при нжатии на конкретное блюдо
//         let recipeDetailVC = appBuilder.makeRecipeDetailsModule(coordinator: self)
//         rootController.pushViewController(recipeDetailVC, animated: true)

        print("Переход на экран категории: \(category)")
        // TODO: Расскомментировать когда Евгений реализует экран categoryDetailViewController
        let categoryViewController = appBuilder.makeRecipesListModule(coordinator: self)
         rootController.pushViewController(categoryViewController, animated: true)
        categoryViewController.categoryTitle = category
    }
    
    func closeRecipeDetails() {
        rootController.popViewController(animated: true)
    }

    func pushProfile() {
        let profileVC = ProfileViewController()
        rootController.pushViewController(profileVC, animated: true)
    }
    
    func pushReceiptDetails() {
        let recipeDetailVC = appBuilder.makeRecipeDetailsModule(coordinator: self)
        rootController.pushViewController(recipeDetailVC, animated: true)
    }
}
