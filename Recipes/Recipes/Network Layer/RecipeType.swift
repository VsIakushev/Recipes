// RecipeType.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Типы еды
enum RecipeType: String {
    /// Салат
    case salad
    /// Суп
    case soup
    /// Панкаке
    case pancake
    /// Выпивка
    case drinks
    /// Десерты
    case desserts
    /// Курица, мясо, рыба, гарнир
    case chicken, meat, fish, sideDish

    var dishCategory: String {
        switch self {
        case .chicken, .meat, .fish, .sideDish:
            return "Main Course"
        case .salad:
            return "salad"
        case .soup:
            return "soup"
        case .pancake:
            return "pancake"
        case .drinks:
            return "drinks"
        case .desserts:
            return "desserts"
        }
    }
}
