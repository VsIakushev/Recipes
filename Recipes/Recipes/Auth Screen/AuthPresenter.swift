// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол авторизации
protocol AuthorizationProtocol: AnyObject {
    /// Проверка логина
    func validateEmail(email: String?)
    /// Проверка пароля
    func checkPassword(password: String?)
    /// проверка авторизации
    func checkAuthorization(email: String, password: String)
}

/// Протокол авторизации экрана
protocol AuthorizationViewControllerProtocol: AnyObject {
    /// устанавливает цвет названия заголовка почты при неправильном вводе
    func setWrongMailLabelColor(color: String, isValidateMail: Bool)
    /// устанавливает цвет названия заголовка почты при правильном вводе
    func setCorrectMailLabelColor(color: String, isValidateMail: Bool)
    /// устанавливает цвет названия заголовка пароля при неправильном вводе
    func setWrongPasswordLabelColor(color: String, isValidatePassword: Bool)
    /// устанавливает цвет названия заголовка почты при правильном вводе
    func setCorrectPasswordLabelColor(color: String, isValidatePassword: Bool)
    /// запуск спиннера
    func startSpinner()
    /// стоп спиннера
    func stopSpinner()
    /// показывает всплывающее окно с ошибкой
    func showErrorView()
}

///  презентер экрана авторизации
final class AuthPresenter {
    // MARK: - Constants

    private enum Constants {
        static let background03 = "background03"
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let selfMatches = "SELF MATCHES %@"
        static let text03 = "text03"
        static let minPasswordCount = 8
    }

    // MARK: - Private Properties

    weak var authCoordinator: AuthCoordinator?
    private weak var view: AuthorizationViewControllerProtocol?

    // MARK: - Initializers

    init(view: AuthorizationViewControllerProtocol) {
        self.view = view
    }

    // MARK: - Properties

    private var isValidateMail = Bool()
    private var isValidatePassword = Bool()

//    func checkAuthorization(email: String, password: String) {
//        validateEmail(email: email)
//        checkPassword(password: password)
//
//        if isValidateMail && isValidatePassword {
//            self.view?.startSpinner()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                self.authCoordinator?.onFinish()
//            }
//        }
//        else {
//            self.view?.showErrorView()
//        }
//    }
}

// MARK: - AuthPresenter + AuthorizationProtocol

extension AuthPresenter: AuthorizationProtocol {
    func checkAuthorization(email: String, password: String) {
        validateEmail(email: email)
        checkPassword(password: password)

        if isValidateMail, isValidatePassword {
            view?.startSpinner()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.authCoordinator?.onFinish()
            }
        } else {
            view?.showErrorView()
        }
    }

    func validateEmail(email: String?) {
        guard let email = email, !email.isEmpty else {
            isValidateMail = false
            view?.setWrongMailLabelColor(color: Constants.background03, isValidateMail: false)
            return
        }

        let emailRegex = Constants.emailRegex
        let emailPredicate = NSPredicate(format: Constants.selfMatches, emailRegex)
        if emailPredicate.evaluate(with: email) {
            view?.setCorrectMailLabelColor(color: Constants.text03, isValidateMail: true)
            isValidateMail = true
        } else {
            view?.setWrongMailLabelColor(color: Constants.background03, isValidateMail: false)
            isValidateMail = false
        }
    }

    func checkPassword(password: String?) {
        guard let password = password, !password.isEmpty else {
            view?.setWrongPasswordLabelColor(color: Constants.background03, isValidatePassword: false)
            isValidatePassword = false
            return
        }

        if password.count < Constants.minPasswordCount {
            view?.setWrongPasswordLabelColor(color: Constants.background03, isValidatePassword: false)
            isValidatePassword = false
            return
        } else {
            view?.setCorrectPasswordLabelColor(color: Constants.text03, isValidatePassword: true)
            isValidatePassword = true
        }
    }
}
