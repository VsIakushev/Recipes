// RecipeDetailsPresentor.swift
// Copyright © RoadMap. All rights reserved.

protocol RecipeDetailsViewControllerProtocol: AnyObject {
    func shareViaTelegramButtonTapped()
    func addToFavoritesTaped()
    func backButtonTapped()
    func showAlert()
}

protocol RecipeDetailsPresenterProtocol {
    var recipe: Recipe { get set }
    var recipeCoordinator: RecipeCoordinator? { get set }
    func addToFavorites()
    func shareViaTelegram()
    func closeDetailsScreen()
}

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
        print(recipeCoordinator)
    }
}
