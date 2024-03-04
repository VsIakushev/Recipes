//
//  Category.swift
//  Recipes
//
//  Created by Vermut xxx on 04.03.2024.
//

import Foundation

/// Категории
struct Category {
    /// Аватар категории
    var avatarImageName: String
    /// Название категории
    var categoryTitle: String
    /// Рецепты
    var recepies: [Recipes]
}
