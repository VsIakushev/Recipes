// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол экрана Профиля пользователя
protocol ProfileViewProtocol: AnyObject {
    /// Обновление экрана после получения новых данных
    func updateView()
    /// Показать алерт для ввода нового имени
    func showEditAlert()
    /// Показать условия и политику конфиденциальности
    func showTermsAndPolicy()
    /// Всплывающий экран для показа Условий и политики конфиденциальности
    var termsView: TermsAndPolicyView { get set }
}

/// Протокол Презентера Профиля пользователя
protocol ProfilePresenterProtocol {
    /// Данные пользователя
    var profileInfo: ProfileInfo { get set }
    /// Выход на экран логина
    func onLogOut()
    /// Обработка нажатия кнопки изменения пользовательских данных
    func editTapped()
    /// Установка нового имени пользователя
    func setName(newName: String)
    /// Обработка нажатия на кнопку бонусов
    func bonusButtonPressed()
    /// Обработка нажатия на Terms and Privacy Policy
    func termsAndPolictPressed(profileViewController: ProfileViewProtocol)
}

/// Презентер для экрана Профиля пользователя
final class ProfilePresenter: ProfilePresenterProtocol {
    // MARK: - Public Properties

    var profileInfo = ProfileInfo()

    // MARK: - Private Properties

    private let memento = ProfileMemento.shared
    private weak var profileCoordinator: ProfileCoordinator?
    private weak var view: ProfileViewProtocol?

    // MARK: - Initializers

    init(view: ProfileViewProtocol, coordinator: ProfileCoordinator) {
        self.view = view
        profileCoordinator = coordinator
        loadUserData()
    }

    // MARK: - Public Methods

    func bonusButtonPressed() {
        profileCoordinator?.showBonusBottomSheet(bonuses: profileInfo.bonuses)
    }

    func termsAndPolictPressed(profileViewController: ProfileViewProtocol) {
        profileCoordinator?.showTermsAndPolicySheet(profileViewController: profileViewController)
    }

    func setName(newName: String) {
        profileInfo.username = newName
        view?.updateView()
    }

    func onLogOut() {
        profileCoordinator?.logOut()
    }

    func editTapped() {
        view?.showEditAlert()
    }

    // MARK: - Private Methods

    private func loadUserData() {
        profileInfo = memento.restoreState()
    }
}
