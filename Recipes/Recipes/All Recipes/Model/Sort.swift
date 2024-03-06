//
//  Sort.swift
//  Recipes
//
//  Created by Vermut xxx on 06.03.2024.
//

import Foundation

/// Сортировка по калорием
enum SortedCalories {
    /// Без сортировки
    case none
    /// Сортировка по возрастанию
    case caloriesLow
    /// Сортировка по убыванию
    case caloriesHigh
}

/// Сортировка по времени
enum SortedTime {
    /// Без сортировки
    case none
    /// Сортировка по возрастанию
    case timeLow
    /// Сортировка по убыванию
    case timeHigh
}
