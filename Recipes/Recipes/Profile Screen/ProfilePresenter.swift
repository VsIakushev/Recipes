// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол экрана Профиля пользователя
protocol ProfileViewProtocol: AnyObject {
    /// Обновление экрана после получения новых данных
    func updateView()
    /// показать алерт для ввода нового имени
    func showEditAlert()

    func showTermsAndPolicy()

    var termsView: TermsAndPolicyView { get set }
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
    func termsAndPolictPressed(profileViewController: ProfileViewProtocol)
    /// сохранение данных пользователя
    func saveUserData()
}

/// Презентер для экрана Профиля пользователя
final class ProfilePresenter: ProfilePresenterProtocol {
    // MARK: - Public Properties

    var profileInfo = ProfileInfo(userName: "SOmeName", userImage: "avatar", email: "", password: "", bonuses: 0)

//    let userManager = UserManager.shared
//    let userDataManager = UserDataManager()

    // MARK: - Private Properties

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

    func loadUserData() {
        guard let profileInfo = UserDataManager.shared.loadUser() else { return }
        self.profileInfo = profileInfo
    }

    func saveUserData() {
        UserDataManager.shared.saveUser(profileInfo)
    }
}
