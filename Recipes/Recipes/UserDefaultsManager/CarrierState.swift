// CarrierState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

class CarrierState {
    var memento: UserMemento?

    let user = UserManager.shared.user

    let userManager = UserManager.shared

//    init(userManager: UserManager) {
//        self.userManager = userManager
//    }

    public func saveUser() {
        memento = userManager.save()
    }

    func loadUser() {
        guard memento != nil else { return }
        userManager.load(memento: memento!)
    }
}
