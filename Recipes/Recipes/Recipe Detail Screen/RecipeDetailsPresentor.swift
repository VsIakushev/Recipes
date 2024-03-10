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
    
    
//    
//    func addToFavoritesTaped(recipe: Recipe)

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
    /// добавление в избранное синглтон
    func addToFavoritesSingleton()
    
    func receiveRecipe(_ recipe: Recipe)
    
    
    
    func setSelectedRecipe(_ recipe: Recipe)

    
    


}

/// Презентер экрана деталей рецепта
final class RecipeDetailsPresenter: RecipeDetailsPresenterProtocol {
    
    weak var recipeCoordinator: RecipeCoordinator?

    // MARK: - Public Properties

    var recipe = Recipe.recipeExample()
    var recipeForFavorites: Recipe?
    var selectedRecipe: Recipe?

    // MARK: - Private Properties
    
    private weak var view: RecipeDetailsViewControllerProtocol?

    // MARK: - Initializers

    init(view: RecipeDetailsViewControllerProtocol, coordinator: RecipeCoordinator) {
        self.view = view
        recipeCoordinator = coordinator
    }

    // MARK: - Public Methods
    
    func setSelectedRecipe(_ recipe: Recipe) {
            selectedRecipe = recipe
        print(selectedRecipe ?? "НИЧЕГО НЕ ПРИШЛО!")
        }
    
    func receiveRecipe(_ recipe: Recipe) {
        self.recipe = recipe
        print(recipe)
    }
    
    

    func addToFavoritesSingleton() {
        FavoritesSingletone.shared.addRecipeToFavorites(selectedRecipe!)
    }
    
    func addToFavorites() {
        guard let selectedRecipe = selectedRecipe else {
                print("selectedRecipe is nil!")
                return
            }
            
            FavoritesSingletone.shared.addRecipeToFavorites(selectedRecipe)
        print("\n\n\nZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ\n\n\n")
        print(selectedRecipe)
        
        //view?.showAlert()
    }

    func shareViaTelegram() {}

    func closeDetailsScreen() {
        recipeCoordinator?.closeRecipeDetails()
    }
}
