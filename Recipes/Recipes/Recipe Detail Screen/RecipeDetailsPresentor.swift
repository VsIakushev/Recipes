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
    func reloadData()
    func updateState()
}

/// Протокол презентера экрана деталей рецепта
protocol RecipeDetailsPresenterProtocol {
    
    var state: ViewState<RecipeNetwork> { get }
    
    /// Данные рецепта
//    var recipe: Recipe { get set }
    var recipe: RecipeNetwork? { get set }
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
    var state: ViewState<RecipeNetwork> = .loading {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.view?.updateState()
            }
        }
    }
    
    //TODO: - реализовать передачу uri сюда при переходе с экрана категорий
    var recipeUri: String?
    
    func getRecipe() {
        state = .loading
        networkService?
            .getRecipeDetail(
                //TODO: - реализовать передачу ссылки
//                uri: recipeUri ?? ""
                uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_37b6f298818e8827d6eb0880ec8ea627"
                
            ) { result in
                switch result {
                case let .success(recipe):
                    self.recipe = recipe
                    self.state = .data(recipe)
                    
                case let .failure(error):
                    self.state = .error(error)
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
