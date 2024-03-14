//
//  RecipeDTO.swift
//  Recipes
//
//  Created by Vermut xxx on 14.03.2024.
//

import Foundation
/// Рецепт
struct RecipeDTO: Codable {
    /// Ссылка
    let uri: String
    /// Название
    let label: String
    /// Картинка
    let image: String
    /// Время готовки
    let totalTime: Int
    /// Вес
    let totalWeight: Double
    /// Ингридиенты
    let ingredientLines: [String]
    /// Все нутриенты
    let totalNutrients: [String: NutrientDTO]
}
