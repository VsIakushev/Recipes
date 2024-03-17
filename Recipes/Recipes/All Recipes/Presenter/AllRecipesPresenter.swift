// AllRecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью  всех рецептов
protocol RecipesViewProtocol: AnyObject {
    /// получение рецептов
    func getRecipes(recipes: [Recipe])
    /// переход на экран категорий
    func goToTheCategory()
    /// обновление таблицы
    func reloadTableView()
    /// нажатие на кнопку сортировка по времени
    func timeButtonPressed(color: String, image: String)
    /// нажатие на кнопку сортировка по калориям
    func caloriesButtonPressed(color: String, image: String)
    /// отсортировать рецепты
    func sortViewRecipes(recipes: [Recipe])
    /// Обновление состояния вью
    func updateState()
    
//    func hideSkeleton()
}

/// Протокол презентера
protocol RecipeProtocol: AnyObject {
    /// получить рецепты
    func getReceipts(searchString: String?)
    /// переход к деталям рецепта
    func goToRecipeDetails(with recipe: Recipe)
    /// переход к категориям
    func goToCategory()
    /// поиск рецептов
    func searchRecipes(text: String)
    /// проверка поиска
    func checkSearch() -> [Recipe]
    /// начать поиск
    func startSearch()
    /// стоп поиск
//    func stopSearch()
    /// отсортировать рецепты
    func sortRecipes(category: [Recipe])
    /// Название категории
    var categoryTitle: String { get }
    /// Состояние загрузки данных
    var state: ViewState<[Recipe]> { get }
}

final class AllRecipesPresenter {
    private enum Constants {
        static let background01 = "background01"
        static let filterLow = "filterLow"
        static let filterHigh = "filterHigh"
        static let background06 = "background06"
        static let filterIcon = "filterIcon"
        static let vegetarianText = "vegetarian"
    }
    
//MARK: - Public Properties
    
    var state: ViewState<[Recipe]> = .loading {
        didSet {
            view?.updateState()
//            view?.reloadTableView()
        }
    }
    
    private weak var view: RecipesViewProtocol?
    private weak var recipesCoordinator: RecipeCoordinator?
//    private var user: Recipe?
    private var isSearching = false
//    private var searchNames: [Recipe] = []
    private var sortedCalories = SortedCalories.none
    private var sortedTime = SortedTime.none
    private var originalRecipes: [Recipe] = []
    private var recipeDetailsPresenter: RecipeDetailsPresenter?
    private var networkService = NetworkService()
    var recipes: [Recipe] = []
    var categoryTitle: String = ""
    private var category: RecipeType

    init(view: RecipesViewProtocol, coordinator: RecipeCoordinator, categoryTitle: String, category: RecipeType) {
        self.view = view
        self.categoryTitle = categoryTitle
        self.category = category
        recipesCoordinator = coordinator
    }

    func buttonCaloriesChange(category: [Recipe]) {
        if sortedCalories == .none {
            sortedCalories = .caloriesLow
            view?.caloriesButtonPressed(color: Constants.background01, image: Constants.filterLow)
            sortRecipes(category: category)
        } else if sortedCalories == .caloriesLow {
            sortedCalories = .caloriesHigh
            view?.caloriesButtonPressed(color: Constants.background01, image: Constants.filterHigh)
            sortRecipes(category: category)
        } else if sortedCalories == .caloriesHigh {
            sortedCalories = .none
            view?.caloriesButtonPressed(color: Constants.background06, image: Constants.filterIcon)
            sortRecipes(category: category)
        }
    }

    /// Метод меняющий состояниие кнопки таймера
    func buttonTimeChange(category: [Recipe]) {
        if sortedTime == .none {
            sortedTime = .timeLow
            view?.timeButtonPressed(color: Constants.background01, image: Constants.filterLow)
            sortRecipes(category: category)
        } else if sortedTime == .timeLow {
            view?.timeButtonPressed(color: Constants.background01, image: Constants.filterHigh)
            sortedTime = .timeHigh
            sortRecipes(category: category)
        } else if sortedTime == .timeHigh {
            sortedTime = .none
            view?.timeButtonPressed(color: Constants.background06, image: Constants.filterIcon)
            sortRecipes(category: category)
        }
    }
}

// MARK: AllRecipesPresenter + RecipeProtocol

extension AllRecipesPresenter: RecipeProtocol {
    func goToRecipeDetails(with recipe: Recipe) {
        recipesCoordinator?.pushReceiptDetails(with: recipe)
    }

    func sortRecipes(category: [Recipe]) {
        var sorted: [Recipe]
        print("CCCCCAAAAAATTTTTEEEEEGGGGGOOOOORRRRRRYYYYY \(recipes)")

        if sortedCalories == .none, sortedTime == .none {
            sorted = recipes.shuffled()
        } else {
            sorted = recipes

            let sortCalories: ((Recipe, Recipe) -> Bool)?
            switch sortedCalories {
            case .caloriesLow:
                sortCalories = { $0.calories ?? 0 < $1.calories ?? 0 }
            case .caloriesHigh:
                sortCalories = { $0.calories ?? 0 > $1.calories ?? 0 }
            default:
                sortCalories = nil
            }

            let sortTime: ((Recipe, Recipe) -> Bool)?
            switch sortedTime {
            case .timeLow:
                sortTime = { $0.cookingTime < $1.cookingTime }
            case .timeHigh:
                sortTime = { $0.cookingTime > $1.cookingTime }
            default:
                sortTime = nil
            }

            sorted = recipes.sorted { (lhs: Recipe, rhs: Recipe) -> Bool in
                if let sortCalories = sortCalories, let sortTime = sortTime {
                    if lhs.calories == rhs.calories {
                        return sortTime(lhs, rhs)
                    } else {
                        return sortCalories(lhs, rhs)
                    }
                } else if let sortCalories = sortCalories {
                    return sortCalories(lhs, rhs)
                } else if let sortTime = sortTime {
                    return sortTime(lhs, rhs)
                }
                return false
            }
        }
        print("SOOOOOOORRRRRRTTTTTTEEEEEEDDDD\(sorted)")

        view?.sortViewRecipes(recipes: sorted)
        view?.reloadTableView()
        self.recipes = sorted
    }

   
    func searchRecipes(text: String) {
        if text.isEmpty {
            // Если текст поиска пустой, восстанавливаем исходный список рецептов
            isSearching = false
            recipes = originalRecipes // Предполагается, что у вас есть переменная originalRecipes, которая хранит исходный список рецептов
        } else {
            // Фильтруем рецепты по тексту поиска
            isSearching = true
            recipes = originalRecipes.filter { $0.name.lowercased().contains(text.lowercased()) }
        }
        view?.reloadTableView()
    }

    func checkSearch() -> [Recipe] {
        return isSearching ? recipes : originalRecipes
    }
    
    
    
//    func checkSearch() -> [Recipe] {
//        if isSearching {
//            return recipes
//        } else {
//            return recipes
//        }
//    }

    func startSearch() {
        isSearching = true
    }

//    func stopSearch() {
//        isSearching = false
//    }

//    func searchRecipes(text: String) {
//        guard !text.isEmpty else {
//            isSearching = false
//            recipes = []
////            view?.reloadTableView()
//            return
//        }
//
//        isSearching = true
//        recipes = recipes.filter { $0.name.lowercased().contains(text.lowercased()) }
////        view?.reloadTableView()
//    }

    func goToCategory() {
        view?.goToTheCategory()
    }

    func getReceipts(searchString: String? = nil) {
        print("GET RECIPEEEEEEES")
//        state = .loading

        var health: String?

        if category == .sideDish {
            health = Constants.vegetarianText
        }

        if let searchString = searchString {
            var query = category.rawValue
            if !query.isEmpty {
                query.append(" ")
            }
            query.append(searchString)
            fetchRecipes(health: health, query: query)
            print("11111111111")
        } else {
            fetchRecipes(health: health, query: category.rawValue)
            print("22222222222")
        }
    }

    private func fetchRecipes(health: String?, query: String?) {
        state = .loading
        networkService.getRecipes(dishType: category, health: health, query: query) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(recipes):
                    self.state = .data(recipes)
                    self.recipes = recipes
                    self.originalRecipes = recipes // Сохранение оригинального списка рецептов
                    self.view?.getRecipes(recipes: recipes)
                    DispatchQueue.main.async {
//                        print("Hiding skeleton view")
//                        self.view?.reloadTableView()
//                        self.view?.hideSkeleton()
                    }

                case let .failure(error):
                    self.state = .error(error)
                    print("Error fetching recipes: \(error)")
                }
            }
        }
    }
}
