// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол экрана Профиля пользователя
protocol ProfileViewProtocol: AnyObject {
    /// Обновление экрана после получения новых данных
    func updateView()
    /// показать алерт для ввода нового имени
    func showEditAlert()
}

/// Протокол Презентера Профиля пользователя
protocol ProfilePresenterProtocol {
    /// данные пользователя
    var profileInfo: ProfileInfo { get set }
    /// выход на экран логина
    func onLogOut()
    /// обработка нажатия кнопки изменения пользовательских данных
    func editTapped()
    /// установка нового имени пользователя
    func setName(newName: String)
    /// обработка нажатия на кнопку бонусов
    func bonusButtonPressed()
    /// обработка нажатия на Terms and Privacy Policy
    func termsAndPolictPressed()
}

/// Презентер для экрана Профиля пользователя
final class ProfilePresenter: ProfilePresenterProtocol {
    // MARK: - Public Properties

    var profileInfo = ProfileInfo(userName: "Anna", userImage: "avatar", bonuses: 99)

    // MARK: - Private Properties

    private weak var profileCoordinator: ProfileCoordinator?
    private weak var view: ProfileViewProtocol?

    // MARK: - Initializers

    init(view: ProfileViewProtocol, coordinator: ProfileCoordinator) {
        self.view = view
        profileCoordinator = coordinator
    }

    // MARK: - Public Methods

    func bonusButtonPressed() {
        profileCoordinator?.showBonusBottomSheet(bonuses: profileInfo.bonuses)
    }
    
    func termsAndPolictPressed() {
        profileCoordinator?.showTermsAndPolicySheet()
        
    }

    func setName(newName: String) {
        profileInfo.userName = newName
        view?.updateView()
    }

    func onLogOut() {
        profileCoordinator?.logOut()
    }

    func editTapped() {
        view?.showEditAlert()
    }
}
