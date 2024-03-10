// Recipe.swift
// Copyright © RoadMap. All rights reserved.

/// Данные рецепта
struct Recipe: Equatable {
    /// Название рецепта
    let title: String
    /// Изображение для рецепта
    let image: String
    /// Вес блюда
    let weight: Int
    /// Время приготовления
    let cookingTime: Int
    /// Калорийность блюда
    let energicKcal: Int
    /// Углеводы на 100гр блюда
    let carbohydrates: Double
    /// Жиры на 100гр блюда
    let fats: Double
    /// Белки на 100гр блюда
    let proteins: Double
    /// Текст с подробным описанием рецепта
    let recipeDescription: String
    /// Избранное или нет
    var isFavorite: Bool = false

    /// Создание примера рецепта
    static func recipeExample() -> Recipe {
        Recipe(
            title: "Simple Fish and Corn",
            image: "fish1",
            weight: 793,
            cookingTime: 60,
            energicKcal: 1322,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            recipeDescription:
            """
            1/2 to 2 fish heads, depending on size, about 5 pounds total
            2 tablespoons vegetable oil
            1/4 cup red or green thai curry paste
            3 tablespoons fish sauce or anchovy sauce
            1 tablespoon sugar
            1 can coconut milk, about 12 ounces
            3 medium size asian eggplants, cut int 1 inch rounds
            Handful of bird's eye chilies
            1/2 cup thai basil leaves
            Juice of 3 limes
            1/2 to 2 fish heads, depending on size, about 5 pounds total
            2 tablespoons vegetable oil
            1/4 cup red or green thai curry paste
            3 tablespoons fish sauce or anchovy sauce
            1 tablespoon sugar
            1 can coconut milk, about 12 ounces
            3 medium size asian eggplants, cut int 1 inch rounds
            Handful of bird's eye chilies
            1/2 cup thai basil leaves
            Juice of 3 limes
            1/2 to 2 fish heads, depending on size, about 5 pounds total
            2 tablespoons vegetable oil
            1/4 cup red or green thai curry paste
            3 tablespoons fish sauce or anchovy sauce
            1 tablespoon sugar
            1 can coconut milk, about 12 ounces
            3 medium size asian eggplants, cut int 1 inch rounds
            Handful of bird's eye chilies
            1/2 cup thai basil leaves
            Juice of 3 limes
            """
        )
    }
    
    static func exampleRecipes() -> [Recipe] {
        [
            Recipe(
                title: "Simple Fish And Corn",
                image: "fish_1",
                weight: 739,
                cookingTime: 60,
                energicKcal: 274,
                carbohydrates: 10.78,
                fats: 10.00,
                proteins: 97.30,
                recipeDescription: ""
            ),
            Recipe(
                title: "Baked Fish with Lemon Herb Sauce",
                image: "fish_2",
                weight: 739,
                cookingTime: 90,
                energicKcal: 616,
                carbohydrates: 10.78,
                fats: 10.00,
                proteins: 97.30,
                recipeDescription: ""
            ),
            Recipe(
                title: "Lemon and Chilli Fish Burrito",
                image: "fish_3",
                weight: 739,
                cookingTime: 90,
                energicKcal: 226,
                carbohydrates: 10.78,
                fats: 10.00,
                proteins: 97.30,
                recipeDescription: ""
            ),
            Recipe(
                title: "Fast Roast Fish & Show Peas Recipes",
                image: "fish_4",
                weight: 739,
                cookingTime: 80,
                energicKcal: 94,
                carbohydrates: 10.78,
                fats: 10.00,
                proteins: 97.30,
                recipeDescription: ""
            ),
            Recipe(
                title: "Salmon with Cantaloupe and Fried Shallots",
                image: "fish_5",
                weight: 739,
                cookingTime: 100,
                energicKcal: 410,
                carbohydrates: 10.78,
                fats: 10.00,
                proteins: 97.30,
                recipeDescription: ""
            ),
            Recipe(
                title: "Chilli and Tomato Fish",
                image: "fish_6",
                weight: 739,
                cookingTime: 100,
                energicKcal: 174,
                carbohydrates: 10.78,
                fats: 10.00,
                proteins: 97.30,
                recipeDescription: ""
            )
        ]
    }

    static let allRecipes: [Recipe] = exampleRecipes()

    /// свойство типа с избранными рецептами
    static var favoritesRecipes = [Recipe]()
//    static var favoritesRecipes = [
//        Recipes(
//            avatarRecipie: "fish_1",
//            titleRecipies: "Simple Fish And Corn",
//            cookingTimeTitle: "60",
//            caloriesTitle: "274"
//        ),
//        Recipes(
//            avatarRecipie: "fish_2",
//            titleRecipies: "Baked Fish with Lemon Herb Sauce",
//            cookingTimeTitle: "90",
//            caloriesTitle: "616"
//        )
//    ]
}

