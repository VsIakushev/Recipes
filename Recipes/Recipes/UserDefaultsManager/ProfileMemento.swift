// ProfileMemento.swift
// Copyright © RoadMap. All rights reserved.

/// Мементо, который использует ProfileDataManager для сохранения и загрузки состояния пользователя
final class ProfileMemento {
    static let shared = ProfileMemento()

    private let profileDataManager = ProfileDataManager()

    func restoreState() -> ProfileInfo {
        profileDataManager.loadUser()
    }

    /// Функция для создания Профиля при первом запуске, имитация предварительной регистрации
    func createUser() -> ProfileInfo {
        var user = ProfileInfo()
        user.username = "Anna"
        user.avatar = "avatar"
        user.email = ""
        user.password = ""
        user.bonuses = 15
        return user
    }
}
