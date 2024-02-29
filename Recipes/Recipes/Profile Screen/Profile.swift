// Profile.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Профиль пользователя
struct Profile {
    /// Имя пользователя
    var userName: String
    /// Название изображения аватарки пользователя
    var userImage: String
    /// Количество бонусов пользователя
    var userBonuses: Int

    /// Создание примера пользователя
    static func mockData() -> Profile {
        Profile(userName: "Anna Morgan", userImage: "avatar", userBonuses: 100)
    }
}
