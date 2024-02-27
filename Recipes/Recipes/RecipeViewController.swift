// RecipeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

class RecipePresenter {
    weak var recipeCoordinator: RecipeCoordinator?

    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }

    func onTap() {
        recipeCoordinator?.pushProfile()
    }
}

class RecipeViewController: UIViewController {
    var presenter: RecipePresenter?

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
            action: #selector(onTap),
            for: .touchUpInside
        )

        view.addSubview(button)

        view.backgroundColor = .white

        title = "Recipes"
    }

    @objc func onTap() {
        presenter?.onTap()
    }
}
