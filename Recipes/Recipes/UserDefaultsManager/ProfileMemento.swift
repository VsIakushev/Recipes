// ProfileMemento.swift
// Copyright © RoadMap. All rights reserved.


/// Мементо, который использует ProfileDataManager для сохранения и загрузки состояния пользователя
final class ProfileMemento {
    
    static let shared = ProfileMemento()
    
    private let profileDataManager = ProfileDataManager()
    
    func saveState(_ profileInfo: ProfileInfo) {
        profileDataManager.saveUser(profileInfo)
    }
    
    func restoreState() -> ProfileInfo? {
        profileDataManager.loadUser()
    }
    
    /// Функция для создания Профиля при первом запуске, имитация предварительной регистрации
    func createUser() -> ProfileInfo {
        ProfileInfo(userName: "Anna", userImage: "avatar", email: "", password: "", bonuses: 95)
    }
}
