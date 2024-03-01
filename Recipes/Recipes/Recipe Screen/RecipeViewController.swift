// RecipeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран рецептов
final class RecipeViewController: UIViewController {
    // MARK: - Public Properties

    var presenter: RecipePresenterProtocol?

    // MARK: - Private Methods

    func setupUI() {
        tabBarItem = UITabBarItem(
            title: "Recipes",
            image: UIImage(named: "muffin"),
            selectedImage: UIImage(named: "muffin.fill")
        )
    }
}

// MARK: - RecipeViewController + RecipeViewControllerProtocol

extension RecipeViewController: RecipeViewControllerProtocol {}
