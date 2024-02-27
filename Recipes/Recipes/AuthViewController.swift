// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

class AuthPresenter {
    weak var authCoordinator: AuthCoordinator?

    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }

    func onTap() {
        authCoordinator?.onFinish()
    }
}

class AuthViewController: UIViewController {
    var presenter: AuthPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue

        let button = UIButton(frame: CGRect(
            x: 100,
            y: 100,
            width: 200,
            height: 60
        ))
        button.setTitle(
            "finishAutorization",
            for: .normal
        )
        button.setTitleColor(
            .systemBlue,
            for: .normal
        )

        button.addTarget(
            self,
            action: #selector(onTap),
            for: .touchUpInside
        )

        view.addSubview(button)
    }

    @objc func onTap() {
        presenter?.onTap()
    }
}
