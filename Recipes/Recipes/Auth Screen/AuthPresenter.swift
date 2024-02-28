// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

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
