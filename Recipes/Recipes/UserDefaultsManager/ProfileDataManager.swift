// ProfileDataManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

class ProfileDataManager {

    // MARK: - Constants

    private enum Constants {
        static let usernameKey = "username"
        static let avatarKey = "avarar"
        static let emailKey = "emailKey"
        static let passwordKey = "passwordKey"
        static let bonusesKey = "bonusesKey"
    }

    // MARK: - Private Properties
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Public Methods

    func loadUser() -> ProfileInfo {
        ProfileInfo()

    }
    
}
