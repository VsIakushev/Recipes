// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран избранных рецептов
final class FavoritesViewController: UIViewController {
    // MARK: - Public Properties

    var presenter: FavoritesPresenterProtocol?

    // MARK: - Public Methods

    func setupUI() {
        tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(named: "favorites"),
            selectedImage: UIImage(named: "favorites.fill")
        )
    }
}

// MARK: - FavoritesViewController + FavoritesViewControllerProtocol

extension FavoritesViewController: FavoritesViewControllerProtocol {}
