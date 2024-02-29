//
//  FavoritesPresenter.swift
//  Recipes
//
//  Created by Vitaliy Iakushev on 28.02.2024.
//

import UIKit

/// Презентер экрана Избранных рецептов
final class FavoritesPresenter {
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
