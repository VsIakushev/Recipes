//
//  Recipes.swift
//  Recipes
//
//  Created by Vermut xxx on 04.03.2024.
//

import Foundation

/// Рецепт
struct Recipes {
    /// Аватар рецепта
    var avatarRecipie: String
    /// Название рецепта
    var titleRecipies: String
    /// Время изготовления блюда
    var cookingTimeTitle: String
    /// Калории блюда
    var caloriesTitle: String
    
    static func exampleRecipe() -> [Recipes] {
        [
        Recipes(
            avatarRecipie: "fish_1",
            titleRecipies: "Simple Fish And Corn",
            cookingTimeTitle: "60",
            caloriesTitle: "274"
        ),
        Recipes(
            avatarRecipie: "fish_2",
            titleRecipies: "Baked Fish with Lemon Herb Sauce",
            cookingTimeTitle: "90",
            caloriesTitle: "616"
        ),
        Recipes(
            avatarRecipie: "fish_3",
            titleRecipies: "Lemon and Chilli Fish Burrito",
            cookingTimeTitle: "90",
            caloriesTitle: "226"
        ),
        Recipes(
            avatarRecipie: "fish_4",
            titleRecipies: "Fast Roast Fish & Show Peas Recipes",
            cookingTimeTitle: "80",
            caloriesTitle: "94"
        ),
        Recipes(
            avatarRecipie: "fish_5",
            titleRecipies: "Salmon with Cantaloupe and Fried Shallots",
            cookingTimeTitle: "100",
            caloriesTitle: "410"
        ),
        Recipes(
            avatarRecipie: "fish_6",
            titleRecipies: "Chilli and Tomato Fish",
            cookingTimeTitle: "100",
            caloriesTitle: "174"
        )]
    }
}
