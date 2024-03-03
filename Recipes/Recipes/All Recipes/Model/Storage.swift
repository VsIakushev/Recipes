//
//  Storage.swift
//  Recipes
//
//  Created by Vermut xxx on 04.03.2024.
//

import Foundation

/// Моковые данные
final class Storage {
    // MARK: - Public Properties

    var fish: [Recipes] = [
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
        )
    ]

    lazy var category: [Category] = [
        .init(avatarImageName: "salad", categoryTitle: "Salad", recepies: []),
        .init(avatarImageName: "soup", categoryTitle: "Soup", recepies: []),
        .init(avatarImageName: "chicken", categoryTitle: "Chicken", recepies: []),
        .init(avatarImageName: "meat", categoryTitle: "Meat", recepies: []),
        .init(avatarImageName: "fish", categoryTitle: "Fish", recepies: fish),
        .init(avatarImageName: "side dish", categoryTitle: "Side dish", recepies: []),
        .init(avatarImageName: "drinks", categoryTitle: "Drinks", recepies: []),
        .init(avatarImageName: "pancake", categoryTitle: "Pancake", recepies: []),
        .init(avatarImageName: "desserts", categoryTitle: "Desserts", recepies: [])
    ]
}

