// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол Презентера Профиля пользователя
protocol ProfilePresenterProtocol {
    func onTap()
    func onLogOut()
}

/// Презентер для экрана Профиля пользователя
final class ProfilePresenter: ProfilePresenterProtocol {
    // MARK: - Public Properties

    weak var profileCoordinator: ProfileCoordinator?

    // MARK: - Private Properties

    private weak var view: UIViewController?

    // MARK: - Initializers

    init(view: UIViewController) {
        self.view = view
    }

    // MARK: - Public Methods

    func onTap() {
        profileCoordinator?.pushRecipe()
    }

    func onLogOut() {
        profileCoordinator?.logOut()
    }
}
