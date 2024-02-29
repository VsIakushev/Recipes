// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана Профиля пользователя
protocol ProfileViewProtocol: AnyObject {
    func updateView()
    func showEditAlert()
}

/// Протокол Презентера Профиля пользователя
protocol ProfilePresenterProtocol {
    var profileInfo: ProfileInfo { get set }
    var profileCoordinator: ProfileCoordinator? { get set }

    func onTap()
    func onLogOut()
    func editTapped()
    func setName(newName: String)
    func bonusButtonPressed()
}

/// Презентер для экрана Профиля пользователя
final class ProfilePresenter: ProfilePresenterProtocol {
    func editTapped() {
        view?.showEditAlert()
    }

    // MARK: - Public Properties

    weak var profileCoordinator: ProfileCoordinator?
    var profileInfo = ProfileInfo(userName: "Anna", userImage: "avatar", bonuses: 99)

    // MARK: - Private Properties

    private weak var view: ProfileViewProtocol?

    // MARK: - Initializers

    init(view: ProfileViewProtocol) {
        self.view = view
    }

    // MARK: - Public Methods

    func bonusButtonPressed() {
        profileCoordinator?.showBonusBottomSheet(bonuses: profileInfo.bonuses)
    }

    func setName(newName: String) {
        profileInfo.userName = newName
        view?.updateView()
    }

    func onTap() {
        profileCoordinator?.pushRecipe()
    }

    func onLogOut() {
        profileCoordinator?.logOut()
    }
}
