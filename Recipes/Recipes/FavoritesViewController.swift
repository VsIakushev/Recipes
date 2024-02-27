// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

class FavoritesPresenter {
    weak var favoritesCoordinator: FavoritesCoordinator?

    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }

    func onTap() {
        favoritesCoordinator?.pushRecipe()
    }

    func onLogOut() {
        favoritesCoordinator?.logOut()
    }
}

final class FavoritesViewController: UIViewController {
    var presenter: FavoritesPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(frame: CGRect(
            x: 100,
            y: 100,
            width: 200,
            height: 60
        ))
        button.setTitle(
            "Push",
            for: .normal
        )
        button.setTitleColor(
            .systemBlue,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(onTapAction),
            for: .touchUpInside
        )
        view.addSubview(button)

        let logOutButton = UIButton(frame: CGRect(
            x: 100,
            y: 200,
            width: 200,
            height: 60
        ))
        logOutButton.setTitle(
            "LogOut",
            for: .normal
        )
        logOutButton.setTitleColor(
            .systemBlue,
            for: .normal
        )
        logOutButton.addTarget(
            self,
            action: #selector(onTapLogOutAction),
            for: .touchUpInside
        )
        view.addSubview(logOutButton)

        view.backgroundColor = .white

        title = "Favorites"
    }

    @objc func onTapAction() {
        presenter?.onTap()
    }

    @objc func onTapLogOutAction() {
        presenter?.onLogOut()
    }
}
