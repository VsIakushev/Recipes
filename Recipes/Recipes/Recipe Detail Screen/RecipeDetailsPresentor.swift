// RecipeDetailsPresentor.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол экрана деталей рецепта
protocol RecipeDetailsViewControllerProtocol: AnyObject {
    /// Передача в презентер что была нажата кнопка "Поделиться в Телеграм"
    func shareViaTelegramButtonTapped()
    /// Передача в презентер что была нажата кнопка "Добавить в избранное"
    func addToFavoritesTaped()
    /// Передача в презентер что была нажата кнопка "Назад"
    func backButtonTapped()
    /// Вызов Алерта о функционале в разработке
    func showAlert()
}

/// Протокол презентера экрана деталей рецепта
protocol RecipeDetailsPresenterProtocol {
    /// Данные рецепта
    var recipe: Recipe { get set }
    /// Координатор Рецептов для навигации
    var recipeCoordinator: RecipeCoordinator? { get set }
    /// Отработка нажатия кнопки "Добавить в избранное"
    func addToFavorites()
    /// Отработка нажатия кнопки "Поделиться в Телеграм"
    func shareViaTelegram()
    /// Отработка нажатия кнопки "Назад" и закрытие экрана
    func closeDetailsScreen()
}

/// Презентер экрана деталей рецепта
final class RecipeDetailsPresenter: RecipeDetailsPresenterProtocol {
    
    weak var recipeCoordinator: RecipeCoordinator?
    
    // MARK: - Public Properties

    var recipe = Recipe.recipeExample()

    // MARK: - Private Properties

    private weak var view: RecipeDetailsViewControllerProtocol?

    // MARK: - Initializers

    init(view: RecipeDetailsViewControllerProtocol, coordinator: RecipeCoordinator) {
        self.view = view
        self.recipeCoordinator = coordinator
    }

    // MARK: - Public Methods

    func addToFavorites() {
        view?.showAlert()
    }

    func shareViaTelegram() {}
    
    func closeDetailsScreen() {
        recipeCoordinator?.closeRecipeDetails()
    }
}