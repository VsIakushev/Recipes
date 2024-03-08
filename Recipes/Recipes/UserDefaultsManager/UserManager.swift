// UserManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

class UserManager {
    static let shared = UserManager()

    var user = ProfileInfo(userName: "Anna", userImage: "avatar", email: "", password: "", bonuses: 97)
//    User(username: "Anna", avatar: "avatar", email: "", password: "", bonuses: 97)

    func save() -> UserMemento {
        UserMemento(user: user)
    }

    func load(memento: UserMemento) {
        guard let user = memento.loadUser() else { return }
        self.user = user
    }

    func loginAndPasswordExist() -> Bool {
        if user.password.isEmpty, user.email.isEmpty {
            return false
        } else {
            return true
        }
    }

    func loginAndPasswordValid(enteredEmail: String, enteredPassword: String) -> Bool {
        if enteredEmail == user.email, enteredPassword == user.password {
            return true
        } else {
            return false
        }
    }

//
//    func ifUserExist() -> Bool {
//        user == nil ? false : true
//    }
//
//    func isLoginAndPasswordValid(enteredEmail: String, enteredPassword: String) -> Bool {
//
//        guard let email = userDefaults.string(forKey: Constants.emailKey),
//              let password = userDefaults.string(forKey: Constants.passwordKey) else { return false }
//
//        if enteredEmail == email && enteredPassword == password {
//            return true
//        } else {
//            return false
//        }
//    }
}
