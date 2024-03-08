// UserDataManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

class UserDataManager {
    static let shared = UserDataManager()

    // MARK: - Constants

    private enum Constants {
        static let usernameKey = "username"
        static let avatarKey = "avarar"
        static let emailKey = "emailKey"
        static let passwordKey = "passwordKey"
        static let bonusesKey = "bonusesKey"
    }

    // MARK: - Private Properties

    private var user = ProfileInfo(userName: "", userImage: "", email: "", password: "", bonuses: 0)
    
    private let userDefaults = UserDefaults.standard

    init() {
        user = loadUser()!
    }
    
    func saveUser(_ user: ProfileInfo) {
        userDefaults.set(user.username, forKey: Constants.usernameKey)
        userDefaults.set(user.avatar, forKey: Constants.avatarKey)
        userDefaults.set(user.email, forKey: Constants.emailKey)
        userDefaults.set(user.password, forKey: Constants.passwordKey)
        userDefaults.set(user.bonuses, forKey: Constants.bonusesKey)
    }

    func loadUser() -> ProfileInfo? {
        let bonuses = userDefaults.integer(forKey: Constants.bonusesKey)
        guard let username = userDefaults.string(forKey: Constants.usernameKey),
              let avatar = userDefaults.string(forKey: Constants.avatarKey),
              let email = userDefaults.string(forKey: Constants.emailKey),
              let password = userDefaults.string(forKey: Constants.passwordKey)
        else {
            return nil
        }
        var profile = ProfileInfo(
            userName: username,
            userImage: avatar,
            email: email,
            password: password,
            bonuses: bonuses
        )
        profile.email = email
        profile.password = password
        return profile
    }
    
    func createUser() -> ProfileInfo {
        ProfileInfo(userName: "Anna", userImage: "avatar", email: "", password: "", bonuses: 95)
    }
    
}
