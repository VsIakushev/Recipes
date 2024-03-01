// RecipePresenter.swift
// Copyright © RoadMap. All rights reserved.

protocol RecipeViewControllerProtocol: AnyObject {}

protocol RecipePresenterProtocol {
    var recipeCoordinator: RecipeCoordinator? { get set }
}

/// Презентер экрана Рецептов
final class RecipePresenter: RecipePresenterProtocol {
    weak var recipeCoordinator: RecipeCoordinator?

    private weak var view: RecipeViewControllerProtocol?

    init(view: RecipeViewControllerProtocol) {
        self.view = view
    }

    func onTap() {
        recipeCoordinator?.pushProfile()
    }
}
