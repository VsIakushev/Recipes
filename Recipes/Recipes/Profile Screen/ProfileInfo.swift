// ProfileInfo.swift
// Copyright © RoadMap. All rights reserved.

/// Профиль пользователя
//struct ProfileInfo {
//    /// Имя пользователя
//    var username: String
//    /// Название изображения аватарки пользователя
//    var avatar: String
//    /// Количество бонусов у пользователя
//    var bonuses: Int
//    /// Email пользователя
//    var email = ""
//    /// Пароль Пользователя
//    var password = ""
//
//    init(userName: String, userImage: String, email: String, password: String, bonuses: Int) {
//        username = userName
//        avatar = userImage
//        self.bonuses = bonuses
//        self.email = email
//        self.password = password
//    }
//}

struct ProfileInfo {
    /// Имя пользователя
    @UserDefaultsWrapper(key: "username", defaultValue: "") var username: String
    /// Название изображения аватарки пользователя
    @UserDefaultsWrapper(key: "avatar", defaultValue: "") var avatar: String
    /// Email пользователя
    @UserDefaultsWrapper(key: "email", defaultValue: "") var email: String
    /// Пароль Пользователя
    @UserDefaultsWrapper(key: "password", defaultValue: "") var password: String
    /// Количество бонусов у пользователя
    @UserDefaultsWrapper(key: "bonuses", defaultValue: 0) var bonuses: Int

}
