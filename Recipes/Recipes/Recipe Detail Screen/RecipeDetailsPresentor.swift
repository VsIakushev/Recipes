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
    func reloadData()
}

/// Протокол презентера экрана деталей рецепта
protocol RecipeDetailsPresenterProtocol {
    /// Данные рецепта
//    var recipe: Recipe { get set }
    var recipe: RecipeNetwork? { get set }
    /// Координатор Рецептов для навигации
//    var recipeCoordinator: RecipeCoordinator? { get set }
    /// Отработка нажатия кнопки "Добавить в избранное"
    func addToFavorites()
    /// Отработка нажатия кнопки "Поделиться в Телеграм"
    func shareViaTelegram()
    /// Отработка нажатия кнопки "Назад" и закрытие экрана
    func closeDetailsScreen()
    /// добавление в избранное синглтон
    func addToFavoritesSingleton()
    /// избранный рецепт
    var favRecipe: Recipe? { get set }
    
    func getRecipe()
}

/// Презентер экрана деталей рецепта
final class RecipeDetailsPresenter: RecipeDetailsPresenterProtocol {
    func getRecipe() {
        networkService?
            .getRecipeDetail(
                uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_37b6f298818e8827d6eb0880ec8ea627"
            ) { result in
                switch result {
                case let .success(recipe):
                    self.recipe = recipe
                    self.view?.reloadData()
                case let .failure(error):
                    print("Error fetching recipes: \(error)")
                }
            }
    }
    
    private weak var recipeCoordinator: RecipeCoordinator?
    private weak var networkService: NetworkServiceProtocol?

    // MARK: - Public Properties

    var recipe: RecipeNetwork?
    var recipeForFavorites: Recipe?
    var selectedRecipe: Recipe?
    var favoritesSingletone = FavoritesSingletone.shared
    var favRecipe: Recipe?

    // MARK: - Private Properties

    private weak var view: RecipeDetailsViewControllerProtocol?

    // MARK: - Initializers

    init(view: RecipeDetailsViewControllerProtocol, coordinator: RecipeCoordinator, networkService: NetworkServiceProtocol) {
        self.view = view
        recipeCoordinator = coordinator
        self.networkService = networkService
    }

    // MARK: - Public Methods

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
