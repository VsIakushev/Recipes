// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран авторизации
class AuthViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let login = "Login"
        static let background03 = "background03"
        static let background02 = "background02"
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let selfMatches = "SELF MATCHES %@"
        static let text03 = "text03"
        static let text01 = "text01"
        static let verdanaBold = "verdana-Bold"
        static let verdana = "Verdana"
        static let emailAddress = "Email Address"
        static let envelope = "envelope"
        static let enterEmailAddress = "Enter Email Address"
        static let incorrectFormat = "Incorrect format"
        static let password = "Password"
        static let lock = "lock"
        static let enterPassword = "Enter Password"
        static let youEnteredTheWrongPassword = "You entered the wrong password"
        static let pleaseCheckTheAccuracy = "Please check the accuracy of the entered credentials."
        static let background04 = "background04"
        static let eyeSlash = "eye.slash.fill"
        static let eye = "eye.fill"
    }
    
    // MARK: - Public Properties
    
    var presenter: AuthPresenter?
    
    // MARK: - Private Properties

    private var loginButtonBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Visual Components
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.login, for: .normal)
        button.backgroundColor = UIColor(named: Constants.background02)
        button.layer.cornerRadius = 12
        button.addTarget(
            self,
            action: #selector(onTap),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.login
        label.font = UIFont(name: Constants.verdanaBold, size: 28)
        label.textColor = UIColor(named: Constants.text01)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailAddressLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.emailAddress
        label.font = UIFont(name: Constants.verdanaBold, size: 18)
        label.textColor = UIColor(named: Constants.text01)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailAddressView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: Constants.text03)?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let envelopeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.envelope)
        image.tintColor = UIColor(named: Constants.text03)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.enterEmailAddress
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailWrongAddressLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.incorrectFormat
        label.font = UIFont(name: Constants.verdanaBold, size: 12)
        label.textColor = UIColor(named: Constants.background03)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.password
        label.font = UIFont(name: Constants.verdanaBold, size: 18)
        label.textColor = UIColor(named: Constants.text01)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: Constants.text03)?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lockImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.lock)
        image.tintColor = UIColor(named: Constants.text03)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.enterPassword
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordWrongLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.youEnteredTheWrongPassword
        label.font = UIFont(name: Constants.verdanaBold, size: 12)
        label.textColor = UIColor(named: Constants.background03)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.eyeSlash), for: .normal)
        button.tintColor = UIColor(named: Constants.text03)
        button.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let errorView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: Constants.background03)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let errorLabel: UILabel = {
       let label = UILabel()
        label.text = Constants.pleaseCheckTheAccuracy
        label.font = UIFont(name: Constants.verdana, size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let spinner = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardObservation()
        emailTextField.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBackgroundColor()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.addSubview(loginButton)
        setupLoginButtonConstraints()
        view.addSubview(loginLabel)
        setupConstraintsForLoginLabel()
        view.addSubview(emailAddressLabel)
        setupConstraintsForEmailAddressLabel()
        view.addSubview(emailAddressView)
        setupConstraintsForEmailAddressView()
        view.addSubview(emailWrongAddressLabel)
        setupConstraintsForEmailWrongAddressLabel()
        emailAddressView.addSubview(envelopeImage)
        setupConstraintsForEnvelopeImage()
        emailAddressView.addSubview(emailTextField)
        setupConstraintsForEmailTextField()
        view.addSubview(passwordLabel)
        setupConstraintsForPasswordLabel()
        view.addSubview(passwordView)
        setupConstraintsForPasswordView()
        view.addSubview(passwordWrongLabel)
        setupConstraintsForPasswordWrongLabel()
        passwordView.addSubview(lockImage)
        setupConstraintsForLockImage()
        passwordView.addSubview(passwordTextField)
        setupConstraintsForPasswordTextField()
        passwordView.addSubview(eyeButton)
        setupConstraintsForEyeImage()
        view.addSubview(errorView)
        setupConstraintsForErrorView()
        errorView.addSubview(errorLabel)
        setupConstraintsForErrorLabel()
        setGestureRecognizer()
}
    
private func setupBackgroundColor() {
    view.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [UIColor.white.cgColor, UIColor(named: Constants.background04)?.cgColor as Any]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    view.layer.insertSublayer(gradientLayer, at: 0)
}
    
private func setupLoginButtonConstraints() {
    loginButtonBottomConstraint = loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -71)
    loginButtonBottomConstraint?.isActive = true
    loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    loginButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
}
    
private func setupConstraintsForLoginLabel() {
    NSLayoutConstraint.activate([
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 82),
        loginLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        loginLabel.widthAnchor.constraint(equalToConstant: 350),
        loginLabel.heightAnchor.constraint(equalToConstant: 32)
    ])
}

private func setupConstraintsForEmailAddressLabel() {
    NSLayoutConstraint.activate([
        emailAddressLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 23),
        emailAddressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        emailAddressLabel.widthAnchor.constraint(equalToConstant: 200),
        emailAddressLabel.heightAnchor.constraint(equalToConstant: 32)
    ])
}
    
private func setupConstraintsForEmailAddressView() {
    NSLayoutConstraint.activate([
        emailAddressView.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor, constant: 6),
        emailAddressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        emailAddressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        emailAddressView.heightAnchor.constraint(equalToConstant: 50)
    ])
}
    
private func setupConstraintsForEnvelopeImage() {
    NSLayoutConstraint.activate([
        envelopeImage.topAnchor.constraint(equalTo: emailAddressView.topAnchor, constant: 18),
        envelopeImage.leadingAnchor.constraint(equalTo: emailAddressView.leadingAnchor, constant: 17),
        envelopeImage.widthAnchor.constraint(equalToConstant: 20),
        envelopeImage.heightAnchor.constraint(equalToConstant: 16)
    ])
}
    
private func setupConstraintsForEmailTextField() {
    NSLayoutConstraint.activate([
        emailTextField.topAnchor.constraint(equalTo: emailAddressView.topAnchor, constant: 14),
        emailTextField.leadingAnchor.constraint(equalTo: emailAddressView.leadingAnchor, constant: 50),
        emailTextField.widthAnchor.constraint(equalToConstant: 255),
        emailTextField.heightAnchor.constraint(equalToConstant: 24)
    ])
}
    
private func setupConstraintsForEmailWrongAddressLabel() {
    NSLayoutConstraint.activate([
        emailWrongAddressLabel.topAnchor.constraint(equalTo: emailAddressView.bottomAnchor),
        emailWrongAddressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        emailWrongAddressLabel.widthAnchor.constraint(equalToConstant: 230),
        emailWrongAddressLabel.heightAnchor.constraint(equalToConstant: 19)
    ])
}
    
private func setupConstraintsForPasswordLabel() {
    NSLayoutConstraint.activate([
        passwordLabel.topAnchor.constraint(equalTo: emailAddressView.bottomAnchor, constant: 23),
        passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        passwordLabel.widthAnchor.constraint(equalToConstant: 200),
        passwordLabel.heightAnchor.constraint(equalToConstant: 32)
    ])
}
    
private func setupConstraintsForPasswordView() {
    NSLayoutConstraint.activate([
        passwordView.topAnchor.constraint(equalTo: emailAddressView.bottomAnchor, constant: 62),
        passwordView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        passwordView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        passwordView.heightAnchor.constraint(equalToConstant: 50)
    ])
}
    
private func setupConstraintsForPasswordWrongLabel() {
    NSLayoutConstraint.activate([
        passwordWrongLabel.topAnchor.constraint(equalTo: passwordView.bottomAnchor),
        passwordWrongLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        passwordWrongLabel.widthAnchor.constraint(equalToConstant: 230),
        passwordWrongLabel.heightAnchor.constraint(equalToConstant: 19)
    ])
}
    
private func setupConstraintsForLockImage() {
    NSLayoutConstraint.activate([
        lockImage.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 14),
        lockImage.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 19),
        lockImage.widthAnchor.constraint(equalToConstant: 16),
        lockImage.heightAnchor.constraint(equalToConstant: 21)
    ])
}
    
private func setupConstraintsForPasswordTextField() {
    NSLayoutConstraint.activate([
        passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 14),
        passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 50),
        passwordTextField.widthAnchor.constraint(equalToConstant: 255),
        passwordTextField.heightAnchor.constraint(equalToConstant: 24)
    ])
}
    
private func setupConstraintsForEyeImage() {
    NSLayoutConstraint.activate([
        eyeButton.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 17),
        eyeButton.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -14),
        eyeButton.widthAnchor.constraint(equalToConstant: 22),
        eyeButton.heightAnchor.constraint(equalToConstant: 19)
    ])
}
    
private func setupConstraintsForErrorView() {
    NSLayoutConstraint.activate([
    errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -83),
    errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
    errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    errorView.heightAnchor.constraint(equalToConstant: 87)
    ])
}
private func setupConstraintsForErrorLabel() {
    NSLayoutConstraint.activate([
    errorLabel.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 16),
    errorLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 15),
    errorLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -34),
    errorLabel.bottomAnchor.constraint(equalTo: errorView.bottomAnchor, constant: -17)
    ])
}
    
    private func setupKeyboardObservation() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    deinit {
            NotificationCenter.default.removeObserver(self)
        }
    
    @objc private func keyboardShow(_ notification: Notification) {
        loginButtonBottomConstraint?.constant = -300
        view.layoutIfNeeded()
        }
        @objc private func keyboardHide(_ notification: Notification) {
            loginButtonBottomConstraint?.constant = -71
                view.layoutIfNeeded()
        }
    
    private func setGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
    }
    
    @objc func eyeButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        let eyeIconName = passwordTextField.isSecureTextEntry ? Constants.eyeSlash : Constants.eye
        eyeButton.setImage(UIImage(systemName: eyeIconName), for: .normal)
    }
    
    @objc func dismissKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        loginButtonBottomConstraint?.constant = -71
        view.layoutIfNeeded()
    }
    

    @objc func onTap() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        self.presenter?.loginButtonPressed(email: email, password: password)
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            presenter?.validateEmail(email: textField.text)
        }
    }
}

extension AuthViewController: AuthorizationViewControllerProtocol {
    func setWrongMailLabelColor(color: String, isValidateMail isValidateLogin: Bool) {
        emailAddressView.layer.borderColor = UIColor(named: Constants.background03)?.cgColor
        emailAddressLabel.textColor = UIColor(named: Constants.background03)
        emailWrongAddressLabel.isHidden = false
    }
    
    func setCorrectMailLabelColor(color: String, isValidateMail isValidateLogin: Bool) {
        emailAddressView.layer.borderColor = UIColor(named: Constants.text03)?.cgColor
        emailAddressLabel.textColor = UIColor(named: Constants.text03)
        emailWrongAddressLabel.isHidden = true
    }
    
    func setWrongPasswordLabelColor(color: String, isValidatePassword: Bool) {
        passwordView.layer.borderColor = UIColor(named: Constants.background03)?.cgColor
        passwordLabel.textColor = UIColor(named: Constants.background03)
        passwordWrongLabel.isHidden = false
    }
    
    func setCorrectPasswordLabelColor(color: String, isValidatePassword: Bool) {
        passwordLabel.textColor = UIColor(named: Constants.text03)
        passwordView.layer.borderColor = UIColor(named: Constants.text03)?.cgColor
        passwordWrongLabel.isHidden = true
    }

    func startSpinner() {
        self.loginButton.setTitle("", for: .normal)
        self.loginButton.addSubview(spinner)
        spinner.color = .white
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: self.loginButton.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.loginButton.centerYAnchor).isActive = true
    }
    
    func stopSpinner() {
        self.loginButton.setTitle(Constants.login, for: .normal)
        self.spinner.removeFromSuperview()
        spinner.stopAnimating()
    }
    
    func showErrorView() {
        self.errorView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.errorView.isHidden = true
        }
    }
}
