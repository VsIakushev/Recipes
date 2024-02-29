//
//  RecipePresebter.swift
//  Recipes
//
//  Created by Vitaliy Iakushev on 28.02.2024.
//

import UIKit

/// Презентер экрана Рецептов
final class RecipePresenter {
    weak var recipeCoordinator: RecipeCoordinator?

    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }

    func onTap() {
        recipeCoordinator?.pushProfile()
    }
}
