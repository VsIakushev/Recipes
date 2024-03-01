// ProfileInfo.swift
// Copyright © RoadMap. All rights reserved.

/// Профиль пользователя
struct ProfileInfo {
    /// Имя пользователя
    var userName: String
    /// Название изображения аватарки пользователя
    let userImage: String
    /// Количество бонусов у пользователя
    let bonuses: Int

    init(userName: String, userImage: String, bonuses: Int) {
        self.userName = userName
        self.userImage = userImage
        self.bonuses = bonuses
    }
}
