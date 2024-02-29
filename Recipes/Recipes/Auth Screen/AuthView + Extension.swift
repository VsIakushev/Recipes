// AuthView + Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Модель
extension AuthViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            validateEmail(email: textField.text)
        }
    }

    func validateEmail(email: String?) {
        guard let email = email, !email.isEmpty else {
            print("Email field is empty.")
            emailAddressView.layer.borderColor = UIColor(named: "background03")?.cgColor
            emailAddressLabel.textColor = UIColor(named: "background03")
            loginButton.isEnabled = false
            emailWrongAddressLabel.isHidden = false
            return
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if emailPredicate.evaluate(with: email) {
            print("Email is valid.")
            emailAddressView.layer.borderColor = UIColor(named: "text03")?.cgColor
            emailAddressLabel.textColor = UIColor(named: "text01")
            loginButton.isEnabled = true
            emailWrongAddressLabel.isHidden = true
        } else {
            print("Email is not valid.")
            emailAddressView.layer.borderColor = UIColor(named: "background03")?.cgColor
            emailAddressLabel.textColor = UIColor(named: "background03")
            loginButton.isEnabled = false
            emailWrongAddressLabel.isHidden = false
        }
    }
}
