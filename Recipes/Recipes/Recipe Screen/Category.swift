//
//  Category.swift
//  Recipes
//
//  Created by Vermut xxx on 03.03.2024.
//

import Foundation

/// Составляющие категории
struct Category {
    /// Аватар
    var avatarImageName: String
    /// Название
    var categoryTitle: String
    /// размер ячейки
//    var sizeCell: SizeCellCategory
    /// Рецепты
    var recepies: [Recipie]
}
