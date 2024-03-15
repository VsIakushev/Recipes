// RecipeCategory.swift
// Copyright © RoadMap. All rights reserved.

struct RecipeCategory {
    let title: String
    let image: String
    let type: RecipeType

    static func createCategories() -> [RecipeCategory] {
        [
            .init(title: "Salad", image: "salad", type: .salad),
            .init(title: "Soup", image: "soup", type: .soup),
            .init(title: "Chicken", image: "chicken", type: .chicken),
            .init(title: "Meat", image: "meat", type: .meat),
            .init(title: "Fish", image: "fish", type: .fish),
            .init(title: "Side dish", image: "sidedish", type: .sideDish),
            .init(title: "Drinks", image: "drinks", type: .drinks),
            .init(title: "Pancake", image: "pancakes", type: .pancake),
            .init(title: "Desserts", image: "desserts", type: .desserts),        ]
    }
}
