//
//  AuthPresenter.swift
//  Recipes
//
//  Created by Vermut xxx on 28.02.2024.
//

import UIKit

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
