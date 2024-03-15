// RecipeNetwork.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Рецепт детальный
struct RecipeNetwork {
    /// Идентификатор
    let uri: String
    /// Картинка
    let image: String
    /// Название
    let name: String
    /// Вес.
    let weight: Double
    /// Время готовки
    let cookingTime: Int
    /// Калории
    let calories: Double?
    /// Угли
    let carbohydrates: Double?
    ///  Жиры
    let fats: Double?
    /// Белки
    let proteins: Double?
    /// Список ингридиентов
    let ingredientLines: [String]

    init(dto: RecipeDTO) {
        uri = dto.uri
        image = dto.image
        name = dto.label
        weight = dto.totalWeight
        cookingTime = dto.totalTime
        calories = dto.totalNutrients["ENERC_KCAL"]?.quantity
        carbohydrates = dto.totalNutrients["CHOCDF"]?.quantity
        fats = dto.totalNutrients["FAT"]?.quantity
        proteins = dto.totalNutrients["PROCNT"]?.quantity
        ingredientLines = dto.ingredientLines
    }
}
