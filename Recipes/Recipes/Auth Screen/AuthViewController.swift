// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Класс презентера
class AuthPresenter {
    // MARK: - Private Properties
    weak var authCoordinator: AuthCoordinator?
    private weak var view: UIViewController?

    // MARK: - Initializers
    init(view: UIViewController) {
        self.view = view
    }

    // MARK: - Properties
    func onTap() {
        authCoordinator?.onFinish()
    }
}

/// Экран авторизации
class AuthViewController: UIViewController {
    var presenter: AuthPresenter?
    // MARK: - Visual Components
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(named: "background02")
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
        label.text = "Login"
        label.font = UIFont(name: "verdana-Bold", size: 28)
        label.textColor = UIColor(named: "text01")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let emailAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Email Address"
        label.font = UIFont(name: "verdana-Bold", size: 18)
        label.textColor = UIColor(named: "text01")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let emailAddressView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "text03")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let envelopeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "envelope")
        image.tintColor = UIColor(named: "text03")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var emailTexField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email Address"
        textField.isUserInteractionEnabled = true
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)

        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "verdana-Bold", size: 18)
        label.textColor = UIColor(named: "text01")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let passwordView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "text03")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let lockImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "lock")
        image.tintColor = UIColor(named: "text03")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.isSecureTextEntry = true
//        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = UIColor(named: "text03")
        button.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardObservation()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBackgroundColor()
    }
    // MARK: - Private Methods
        private func setupUI() {
            view.addSubview(loginButton)
            setupConstraintsForLoginButton()
            view.addSubview(loginLabel)
            setupConstraintsForLoginLabel()
            view.addSubview(emailAddressLabel)
            setupConstraintsForEmailAddressLabel()
            view.addSubview(emailAddressView)
            setupConstraintsForEmailAddressView()
            emailAddressView.addSubview(envelopeImage)
            setupConstraintsForEnvelopeImage()
            emailAddressView.addSubview(emailTexField)
            setupConstraintsForEmailTextField()
            view.addSubview(passwordLabel)
            setupConstraintsForPasswordLabel()
            view.addSubview(passwordView)
            setupConstraintsForPasswordView()
            passwordView.addSubview(lockImage)
            setupConstraintsForLockImage()
            passwordView.addSubview(passwordTextField)
            setupConstraintsForPasswordTextField()
            passwordView.addSubview(eyeButton)
            setupConstraintsForEyeImage()
    }
    /// установка цвета заднего фона
    private func setupBackgroundColor() {
        view.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(named: "background04")?.cgColor as Any]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    private func setupConstraintsForLoginButton() {
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -71),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 35)
        ])
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
            emailTexField.topAnchor.constraint(equalTo: emailAddressView.topAnchor, constant: 14),
            emailTexField.leadingAnchor.constraint(equalTo: emailAddressView.leadingAnchor, constant: 50),
            emailTexField.widthAnchor.constraint(equalToConstant: 255),
            emailTexField.heightAnchor.constraint(equalToConstant: 24)
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
    private func setupKeyboardObservation() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    @objc private func keyboardShow(_ notification: Notification) {
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
        emailTexField.becomeFirstResponder()
        print("Keyboard appeared")

        }

        @objc private func keyboardHide(_ notification: Notification) {
            // Обработка события закрытия клавиатуры
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -71).isActive = true
            print("Keyboard hidden")
        }
    @objc private func textFieldDidBeginEditing(_ textField: UITextField) {
        // if textField == emailTexField {
            textField.becomeFirstResponder()
        // }
    }
    @objc func eyeButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        let eyeIconName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        eyeButton.setImage(UIImage(systemName: eyeIconName), for: .normal)
    }

    @objc func onTap() {
        presenter?.onTap()
    }
}
