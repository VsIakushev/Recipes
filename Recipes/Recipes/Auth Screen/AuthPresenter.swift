//
//  AuthPresenter.swift
//  Recipes
//
//  Created by Vermut xxx on 28.02.2024.
//

import UIKit

/// Протокол авторизации
protocol AuthorizationProtocol: AnyObject {
    /// Проверка логина
    func validateEmail(email: String?)
    /// Проверка пароля
    func checkPassword(password: String?)
}

/// Протокол авторизации экрана
protocol AuthorizationViewControllerProtocol: AnyObject {
    func setWrongMailLabelColor(color: String, isValidateMail: Bool)
    
    func setCorrectMailLabelColor(color: String, isValidateMail: Bool)
    
    func setWrongPasswordLabelColor(color: String, isValidatePassword: Bool)
    
    func setCorrectPasswordLabelColor(color: String, isValidatePassword: Bool)
        
    func startSpinner()
    
    func stopSpinner()
    
    func showErrorView()
}

class AuthPresenter {
    
    //MARK: - Constants
    
    private enum Constants {
        static let background03 = "background03"
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let selfMatches = "SELF MATCHES %@"
        static let text03 = "text03"
        
    }
    // MARK: - Private Properties
    
    weak var authCoordinator: AuthCoordinator?
    private weak var view: AuthorizationViewControllerProtocol?

    // MARK: - Initializers
    
    init(view: AuthorizationViewControllerProtocol) {
        self.view = view
    }

    // MARK: - Properties
    var isValidateMail = Bool()
    var isValidatePassword = Bool()
    
    func loginButtonPressed(email: String, password: String) {
        validateEmail(email: email)
        checkPassword(password: password)
        
        if isValidateMail && isValidatePassword {
            self.view?.startSpinner()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.authCoordinator?.onFinish()
            }
        }
        else {
            self.view?.showErrorView()
        }
    }
}

// MARK: - AuthorizationProtocol

extension AuthPresenter: AuthorizationProtocol {
    
    func validateEmail(email: String?) {
        guard let email = email, !email.isEmpty else {
            self.isValidateMail = false
            view?.setWrongMailLabelColor(color: Constants.background03, isValidateMail: false)
            return
        }
        
        let emailRegex = Constants.emailRegex
        let emailPredicate = NSPredicate(format:Constants.selfMatches, emailRegex)
        if emailPredicate.evaluate(with: email) {
            view?.setCorrectMailLabelColor(color: Constants.text03, isValidateMail: true)
            self.isValidateMail = true
        } else {
            view?.setWrongMailLabelColor(color: Constants.background03, isValidateMail: false)
            self.isValidateMail = false
        }
    }
    
    func checkPassword(password: String?) {
        guard let password = password, !password.isEmpty else {
            view?.setWrongPasswordLabelColor(color: Constants.background03, isValidatePassword: false)
            self.isValidatePassword = false
            return
        }
        
        if password.count < 8 {
            view?.setWrongPasswordLabelColor(color: Constants.background03, isValidatePassword: false)
            self.isValidatePassword = false
            return
        } else {
            view?.setCorrectPasswordLabelColor(color: Constants.text03, isValidatePassword: true)
            self.isValidatePassword = true

        }
    }
}
