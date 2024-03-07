// RecipeCategory.swift
// Copyright © RoadMap. All rights reserved.

struct RecipeCategory {
    let title: String
    let image: String

    static func createCategories() -> [RecipeCategory] {
        [
            .init(title: "Salad", image: "salad"),
            .init(title: "Soup", image: "soup"),
            .init(title: "Chicken", image: "chicken"),
            .init(title: "Meat", image: "meat"),
            .init(title: "Fish", image: "fish"),
            .init(title: "Side dish", image: "sidedish"),
            .init(title: "Drinks", image: "drinks"),
            .init(title: "Pancake", image: "pancakes"),
            .init(title: "Desserts", image: "desserts"),
        ]
    }
}
