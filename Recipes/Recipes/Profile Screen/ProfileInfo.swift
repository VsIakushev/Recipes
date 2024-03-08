// ProfileInfo.swift
// Copyright © RoadMap. All rights reserved.

/// Профиль пользователя
struct ProfileInfo {
    /// Имя пользователя
    var username: String
    /// Название изображения аватарки пользователя
    var avatar: String
    /// Количество бонусов у пользователя
    var bonuses: Int
    /// Email пользователя
    var email = ""
    /// Пароль Пользователя
    var password = ""

    init(userName: String, userImage: String, email: String, password: String, bonuses: Int) {
        username = userName
        avatar = userImage
        self.bonuses = bonuses
        self.email = email
        self.password = password
    }
}
