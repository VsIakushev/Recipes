// Recipe.swift
// Copyright © RoadMap. All rights reserved.

struct Recipe {
    let title: String
    let image: String
    let weight: Int
    let cookintTime: Int
    let energicKcal: Int
    let carbohydrates: Double
    let fats: Double
    let proteins: Double
    let recipeDescription: String

    static func recipeExample() -> Recipe {
        Recipe(
            title: "Simple Fish and Corn",
            image: "fish1",
            weight: 793,
            cookintTime: 60,
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
}
