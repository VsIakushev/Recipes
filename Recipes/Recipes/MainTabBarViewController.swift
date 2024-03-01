// MainTabBarViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ТабБар навигации приложения
final class MainTabBarViewController: UITabBarController {
    // MARK: - Constants

    private enum Constants {
        static let background01Color = "background01"
        static let text02Color = "text02"
    }

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .white
        tabBar.tintColor = UIColor(named: Constants.background01Color)
        tabBar.unselectedItemTintColor = UIColor(named: Constants.text02Color)
    }
}
