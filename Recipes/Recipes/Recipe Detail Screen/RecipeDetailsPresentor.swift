// RecipeDetailsPresentor.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

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
    /// Перезагрузить данные в таблице
    func reloadData()
    /// Обновить состояние загрузки данных
    func updateState()
}

/// Протокол презентера экрана деталей рецепта
protocol RecipeDetailsPresenterProtocol {
    /// Состояние загрузки данных
    var state: ViewState<Recipe> { get }
    /// Координатор Рецептов для навигации
    var recipeUri: String? { get }
    /// Отработка нажатия кнопки "Добавить в избранное"
    func addToFavorites()
    /// Отработка нажатия кнопки "Поделиться в Телеграм"
    func shareViaTelegram()
    /// Отработка нажатия кнопки "Назад" и закрытие экрана
    func closeDetailsScreen()
    /// Добавление в избранное синглтон
    func addToFavoritesSingleton()
    /// Избранный рецепт
    var favRecipe: Recipe? { get set }
    /// Загрузка выбранного рецепта по сети
    func getRecipe()
}

/// Презентер экрана деталей рецепта
final class RecipeDetailsPresenter: RecipeDetailsPresenterProtocol {
    // MARK: - Public Properties

    var state: ViewState<Recipe> = .loading {
        didSet {
            view?.updateState()
        }
    }

    var recipeUri: String?
    var recipeForFavorites: Recipe?
    var selectedRecipe: Recipe?
    var favoritesSingletone = FavoritesSingletone.shared
    var favRecipe: Recipe?

    // MARK: - Private Properties

    private weak var view: RecipeDetailsViewControllerProtocol?
    private weak var recipeCoordinator: RecipeCoordinator?
    private var networkService: NetworkServiceProtocol?

    // MARK: - Initializers

    init(
        view: RecipeDetailsViewControllerProtocol,
        coordinator: RecipeCoordinator,
        networkService: NetworkServiceProtocol
    ) {
        self.view = view
        recipeCoordinator = coordinator
        self.networkService = networkService
    }

    // MARK: - Public Methods

    func getRecipe() {
        state = .loading
        networkService?
            .getRecipeDetail(uri: recipeUri ?? "") { result in
                switch result {
                case let .success(recipe):
                    self.state = .data(recipe)
                case let .failure(error):
                    self.state = .error(error)
                    print("Error fetching recipes: \(error)")
                }
            }
    }

    func addToFavoritesSingleton() {
        guard let selectedRecipe = selectedRecipe else {
            return
        }

        favoritesSingletone.addRecipeToFavorites(selectedRecipe)
    }

    func addToFavorites() {
        guard let favRecipe = favoritesSingletone.recipeFromList else {
            print("selectedRecipe is nil!")
            return
        }

        favoritesSingletone.addRecipeToFavorites(favRecipe)
    }

    func shareViaTelegram() {
        view?.showAlert()
    }

    func closeDetailsScreen() {
        recipeCoordinator?.closeRecipeDetails()
    }
}
