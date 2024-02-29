// RecipePresebter.swift
// Copyright © RoadMap. All rights reserved.

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
