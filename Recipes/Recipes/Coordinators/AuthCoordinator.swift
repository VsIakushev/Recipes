// AuthCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор авторизации
final class AuthCoordinator: BaseCoodinator {
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?

    override func start() {
        showLogin()
    }

    func onFinish() {
        onFinishFlow?()
    }

    func showLogin() {
        let authViewController = AuthViewController()
        let authPresenter = AuthPresenter(view: authViewController)
        authViewController.presenter = authPresenter
        authPresenter.authCoordinator = self

        let rootController = UINavigationController(rootViewController: authViewController)
        setAsRoot​(​_​: rootController)
        self.rootController = rootController
    }

    func nextVC() {
        let authViewController = AuthViewController()
        rootController?.pushViewController(authViewController, animated: true)
    }
}