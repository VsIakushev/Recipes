// RecipePresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол экрана Рецептов
protocol RecipeViewControllerProtocol: AnyObject {}

/// Протокол Презентера экрана Рецептов
protocol RecipePresenterProtocol {
    /// Категории Рецептов
    var categories: [RecipeCategory] { get set }
    /// Переход на экран Категории рецептов
    func goToCategoryListScreen(for category: String)
    /// Координатор рецептов //TODO: - убрать когда сделаю координатор приватным
    var recipeCoordinator: RecipeCoordinator? { get set }
}

/// Презентер экрана Рецептов
final class RecipePresenter: RecipePresenterProtocol {
    
    // MARK: - Public Properties
    var categories = RecipeCategory.createCategories()

    weak var recipeCoordinator: RecipeCoordinator?

    // MARK: - Private Properties
    private weak var view: RecipeViewControllerProtocol?

    // MARK: - Initializers
    init(view: RecipeViewControllerProtocol) {
        self.view = view
    }

    // MARK: - Public Methods
    func goToCategoryListScreen(for category: String) {
        recipeCoordinator?.pushCategoryDetails(for: category)
    }

    func onTap() {
        recipeCoordinator?.pushProfile()
    }
}
