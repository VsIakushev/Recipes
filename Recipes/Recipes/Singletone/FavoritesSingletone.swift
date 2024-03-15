// FavoritesSingletone.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Синглтон
final class FavoritesSingletone {
    static let shared = FavoritesSingletone()

    // UserDefaultsWrapper для массива favoritesList
    @UserDefaultsWrapper(key: "FavoritesList", defaultValue: Data())
    private var favoritesListData: Data

    // Массив рецептов
    var favoritesList: [RecipeNetwork] {
        get {
            // Попытка декодирования сохраненных данных в массив Recipe
            if let decodedFavoritesList = try? PropertyListDecoder().decode([RecipeNetwork].self, from: favoritesListData) {
                return decodedFavoritesList
            } else {
                // В случае ошибки возвращаем пустой массив
                return []
            }
        }
        set {
            // Сериализация массива в Data
            if let encodedFavoritesList = try? PropertyListEncoder().encode(newValue) {
                // Сохранение сериализованного массива в UserDefaults
                favoritesListData = encodedFavoritesList
            }
        }
    }

    var recipeFromList: RecipeNetwork?

    private init() {}

    func addRecipeToFavorites(_ recipe: RecipeNetwork) {
        guard !favoritesList.contains(recipe) else {
            return
        }

        favoritesList.append(recipe)
    }

    func getRecipeFromList(_ recipe: RecipeNetwork) {
        recipeFromList = recipe
    }
}
