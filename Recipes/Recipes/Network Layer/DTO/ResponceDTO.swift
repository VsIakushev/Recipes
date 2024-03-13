//
//  ResponceDTO.swift
//  Recipes
//
//  Created by Vermut xxx on 14.03.2024.
//

import Foundation
/// Ответ с апи
struct ResponseDTO: Codable {
    /// Хитсы
    let hits: [HitDTO]
}
