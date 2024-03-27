// ResponceDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ с апи
struct ResponseDTO: Codable {
    /// Хитсы
    let hits: [HitDTO]
}
